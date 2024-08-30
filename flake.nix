{
  description = "Nix configurations for all my machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
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
    ...
  } @ inputs: let
    secrets = builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [inputs.treefmt-nix.flakeModule];

      systems = ["aarch64-darwin" "x86_64-linux"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        devShells = {
          default = pkgs.mkShell {
            name = "nix-config";
            packages = with pkgs; [nil];
          };
        };

        treefmt = {
          projectRootFile = "flake.nix";
          # Add nix formatter
          programs.alejandra.enable = true;
        };
      };

      flake = {
        darwinConfigurations = let
          username = "${secrets.work.username}";
          system = "aarch64-darwin";
        in {
          "${secrets.work.hostname}" = nix-darwin.lib.darwinSystem {
            inherit system;
            specialArgs = inputs // {inherit username;};
            modules = [
              ./hosts/darwin-work/configuration.nix
              home-manager.darwinModules.home-manager
              {
                home-manager = {
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
