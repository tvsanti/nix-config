{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/tailscale.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "pc-xabia-home";

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. Leave it at the release
  # version of the first install of this system.
  system.stateVersion = "24.05";
}
