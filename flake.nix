{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    opencode.url = "github:anomalyco/opencode?ref=v1.1.51";
  };

  outputs = { self, nixpkgs, home-manager, opencode, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem rec {
          inherit system;

          modules = [
            home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = { inherit inputs; }; }
            ./hosts/laptop/configuration.nix
            ./home/home.nix
            ./common/default.nix
          ];
        };

        pc-work-home = nixpkgs.lib.nixosSystem rec {
          inherit system;

          modules = [
            home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = { inherit inputs; }; }
            ./hosts/pc-work-home/configuration.nix
            ./home/home.nix
            ./common/default.nix
          ];
        };

        pc-xabia-home = nixpkgs.lib.nixosSystem rec {
          inherit system;

          modules = [
            home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = { inherit inputs; }; }
            ./hosts/pc-xabia-home/configuration.nix
            ./home/home.nix
            ./common/default.nix
          ];
        };

        pc-work-office = nixpkgs.lib.nixosSystem rec {
          inherit system;

          modules = [
            home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = { inherit inputs; }; }
            ./hosts/pc-work-office/configuration.nix
            ./home/home.nix
            ./common/default.nix
          ];
        };
      };
    };
}
