{ user, ... }:
{
    hardware.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;
    };

    users.users.santiago = {
      extraGroups = [ "audio" ];
    };
}