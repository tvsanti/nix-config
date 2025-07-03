{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    scripts = {
      url = "github:huuff/nix-scripts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, scripts }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem rec {
          inherit system;
          specialArgs = { scripts = scripts.packages.x86_64-linux; };

          modules = [
            home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = specialArgs; }
            ./hosts/laptop/configuration.nix
            ./home/home.nix
            ./common/default.nix
          ];
        };

        pc-work-home = nixpkgs.lib.nixosSystem rec {
          inherit system;
          specialArgs = { scripts = scripts.packages.x86_64-linux; };

          modules = [
            home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = specialArgs; }
            ./hosts/pc-work-home/configuration.nix
            ./home/home.nix
            ./common/default.nix
          ];
        };

      };
    };
}
