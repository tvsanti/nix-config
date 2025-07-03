{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      fira-code
      fira-code-symbols
      hack-font
      nerd-fonts._0xproto
      nerd-fonts.droid-sans-mono
    ];
    fontconfig.antialias = true;
  };
}