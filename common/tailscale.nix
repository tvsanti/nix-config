# Not part of common/default.nix on purpose: the laptop doesn't use tailscale.
# Hosts that want it import this file explicitly.
{ ... }:
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  networking.firewall.enable = false; # For tails
}
