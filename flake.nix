{
  description = "NixOS + home-manager configuration for all my machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      hosts = [ "laptop" "pc-work-home" "pc-xabia-home" "pc-work-office" ];

      mkHost = hostName:
        nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/${hostName}/configuration.nix
            ./home/home.nix
            ./common/default.nix
          ];
        };
    in {
      nixosConfigurations = nixpkgs.lib.genAttrs hosts mkHost;
    };
}
