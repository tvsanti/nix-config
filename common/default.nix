{ config, pkgs, lib, ... }:

{
  imports = [ ./audio.nix ./bluetooth.nix ./fonts.nix ./java.nix ];
}
