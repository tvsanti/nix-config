{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "pc-work-home";
    networkmanager.enable = true;
    firewall.enable = false; # For tails
  };

  time.timeZone = "Europe/Madrid";

  i18n.defaultLocale = "es_ES.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };
  services.udev.packages = [ pkgs.ledger-udev-rules ];
  environment.pathsToLink =
    [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  services.jellyfin.enable = true;
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  services.xserver = {
    videoDrivers = [ "modesetting" ];
    enable = true;
    libinput = {
      enable = true;
      touchpad.scrollMethod = "edge";
    };
    displayManager = {
      lightdm.enable = true;
      startx.enable = true;
      defaultSession = "xsession";
      session = [{
        manage = "desktop";
        name = "xsession";
        start = "exec $HOME/.xsession";
      }];
    };
    desktopManager = { xterm.enable = false; };
    xrandrHeads = [
      {
        output = "HDMI-1";
        primary = true;
      }
      {
        output = "HDMI-2";
        primary = false;
      }
    ];
    layout = "es";
    xkbOptions = "eurosign:e";
  };

  console.keyMap = "es";
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
  services.printing.enable = true;

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  users.users.santiago = {
    isNormalUser = true;
    description = "Santiago";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "24.05"; # Did you read the comment?

}

