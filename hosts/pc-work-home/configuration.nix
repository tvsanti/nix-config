{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/tailscale.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pc-work-home";

  services.udev.packages = [ pkgs.ledger-udev-rules ];

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. Leave it at the release
  # version of the first install of this system.
  system.stateVersion = "24.05";
}
