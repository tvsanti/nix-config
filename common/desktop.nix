{ ... }:
{
  environment.pathsToLink =
    [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  services.libinput = {
    enable = true;
    touchpad.scrollMethod = "edge";
  };

  services.displayManager.defaultSession = "xsession";

  services.xserver = {
    videoDrivers = [ "modesetting" ];
    enable = true;
    displayManager = {
      lightdm.enable = true;
      startx.enable = true;
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
    xkb.layout = "es";
    xkb.options = "eurosign:e";
  };

  services.printing.enable = true;
}
