{ ... }: {

  # TODO: This should be triggered when plugging or disconecting monitors,
  # but I think there's no udev rule? I should investigate it further
  services.autorandr.enable = true;
  programs.autorandr = {
    enable = true;
    profiles = 
    let
      laptopScreenFingerprint =  "00ffffffffffff000daef515000000000c1d0104a52213780228659759548e271e505400000001010101010101010101010101010101363680a0703820403020a60058c110000018000000fe004e3135364847412d4541330a20000000fe00434d4e0a202020202020202020000000fe004e3135364847412d4541330a200006";
      laptopHdmiFingerprint =  "00ffffffffffff0009d1e57845540000341d010380361e782e9055a75553a028135054a56b80d1c081c081008180a9c0b30001010101023a801871382d40582c4500202f2100001e000000ff0050434b30313438343031390a20000000fd00324c1e5311000a202020202020000000fc0042656e5120474c323538300a2001f7020322f14f901f05140413031207161501061102230907078301000065030c001000023a801871382d40582c4500202f2100001e011d8018711c1620582c2500202f2100009e011d007251d01e206e285500202f2100001e8c0ad08a20e02d10103e9600202f21000018000000000000000000000000000000000000000000a5";
    in
    {
      portable = {
        fingerprint = {
          "eDP-1" = laptopScreenFingerprint;
        };
        config = {
          "eDP-1" = {
            enable = true;
            primary = true;
            mode = "1920x1080";
          };
        };
      };
      docked = {
        fingerprint = {
          "eDP-1" = laptopScreenFingerprint;
          "HDMI-1" = laptopHdmiFingerprint;
        };

        config = {
          "eDP-1" = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            position = "0x0";
          };
          "HDMI-1" = {
            enable = true;
            mode = "1920x1080";
            position = "1920x0";
          };
        };
      };
    };
    hooks = {
      postswitch = {
        # TODO: embed the package to ensure it's always present
        notify = ''notify-send "Switched screen profile" "$AUTORANDR_CURRENT_PROFILE"'';
      }; 
    };
  };


}