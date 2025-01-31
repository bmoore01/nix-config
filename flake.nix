{
  description = "Nix configurations for all my machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";

    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    flake-parts,
    treefmt-nix,
    agenix,
    zjstatus,
    ...
  } @ inputs: let
    secrets = builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.git-hooks-nix.flakeModule
      ];

      systems = ["aarch64-darwin" "x86_64-linux"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        _module.args.pkgs = import self.inputs.nixpkgs {
          inherit system;
          overlays = [self.overlays.default];
          config.allowUnfree = true;
        };

        devShells = {
          default = pkgs.mkShell {
            name = "nix-config";
            packages = with pkgs; [nil];

            shellHook = ''
              ${config.pre-commit.installationScript}
            '';
          };
        };

        pre-commit = {
          check.enable = true;
          settings.hooks = {
            check-merge-conflicts.enable = true;
            # deadnix.enable = true;
            # flake-checker.enable = true;
            treefmt.enable = true;
          };
        };

        treefmt = {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
        };
      };

      flake = {
        overlays.default = inputs.nixpkgs.lib.composeManyExtensions [
          inputs.emacs-overlay.overlays.emacs
          (final: prev: {
            zjstatus = zjstatus.packages.${prev.system}.default;
          })
        ];

        darwinConfigurations = let
          username = "${secrets.work.username}";
          system = "aarch64-darwin";
        in {
          "${secrets.work.hostname}" = nix-darwin.lib.darwinSystem {
            inherit system;
            specialArgs = inputs // {inherit username;};
            modules = [
              ./hosts/darwin-work/configuration.nix
              {
                nixpkgs.overlays = [
                  self.overlays.default
                ];
              }
              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  users."${username}" = import ./hosts/darwin-work/home.nix;
                  extraSpecialArgs = {inherit inputs username secrets;};
                };
                users.users."${username}".home = "/Users/${username}";
              }
            ];
          };
        };

        nixosConfigurations = let
          username = "${secrets.personal.username}";
          system = "x86_64-linux";
        in {
          "${secrets.personal.hostname}" = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = inputs // {inherit username secrets;};
            modules = [
              ./hosts/nixos-desktop/configuration.nix
              {
                nixpkgs.overlays = [
                  self.overlays.default
                ];
              }
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users."${username}" = import ./hosts/nixos-desktop/home.nix;
                  extraSpecialArgs = {inherit inputs username secrets;};
                };
              }
            ];
          };
        };
      };
    };
}
