{ config, pkgs, lib, ... }:

{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./core.nix
    ./desktop.nix
    ./fonts.nix
    ./java.nix
    ./nix.nix
  ];
}
