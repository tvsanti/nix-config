# Orca (https://www.onorca.dev): worktree IDE for AI coding agents.
# Upstream only ships an AppImage for Linux, so wrap it in an FHS env.
# To update: bump `version` and refresh `hash` with
#   nix-prefetch-url https://github.com/stablyai/orca/releases/download/v<version>/orca-linux.AppImage
{ pkgs }:

let
  pname = "orca-ide";
  version = "1.4.188";

  src = pkgs.fetchurl {
    url =
      "https://github.com/stablyai/orca/releases/download/v${version}/orca-linux.AppImage";
    hash = "sha256-LnDLXhmXQeVgKnBgglV1MZ9eA7wvqkuJzScyjz9V1LQ=";
  };

  # Only used to pull the desktop entry and icon out of the image.
  appimageContents = pkgs.appimageTools.extract { inherit pname version src; };
in pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  # git: Orca drives worktrees. libsecret: Electron safeStorage keyring.
  extraPkgs = pkgs: with pkgs; [ git libsecret ];

  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/${pname}.desktop \
      -t $out/share/applications
    install -Dm444 ${appimageContents}/${pname}.png \
      -t $out/share/icons/hicolor/512x512/apps
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
  '';

  meta = {
    description = "Next-gen IDE for parallel agentic development";
    homepage = "https://www.onorca.dev";
    license = pkgs.lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
