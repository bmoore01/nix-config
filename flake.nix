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

    agenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    agenix,
    home-manager,
    ...
  } @ inputs: let
    secrets = builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
  in {
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

    devShell."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".mkShell {
      buildInputs = [
        nixpkgs.legacyPackages."x86_64-linux".nil
      ];
    };

    devShell."aarch64-darwin" = nixpkgs.legacyPackages."aarch64-darwin".mkShell {
      buildInputs = [
        nixpkgs.legacyPackages."aarch64-darwin".nil
      ];
    };

    # nix code formatter
    formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".alejandra;
    formatter."aarch64-darwin" = nixpkgs.legacyPackages."aarch64-darwin".alejandra;
  };
}
