{
  description = "My Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

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
    username = "${secrets.work.username}";
    system = "aarch64-darwin";
  in {
    darwinConfigurations."${secrets.work.hostname}" = nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = inputs // {inherit username;};
      modules = [
        ./hosts/darwin
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            users."${username}" = import ./home.nix;
            extraSpecialArgs = {inherit inputs username secrets;};
          };
          users.users."${username}".home = "/Users/${username}";
        }
      ];
    };

    # nix code formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
