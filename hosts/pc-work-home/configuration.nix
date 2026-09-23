{ pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/tailscale.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pc-work-home";

  services.udev.packages = [ pkgs.ledger-udev-rules ];

  # --- Workaround: DMCUB de la iGPU Rembrandt (Radeon 680M) -----------------
  # El yellow_carp_dmcub.bin de linux-firmware en nixos-unstable no lo
  # consigue cargar el PSP en esta GPU:
  #     amdgpu: failed to load ucode DMCUB(0x3D)
  #     [drm] Wait for DMUB auto-load failed: 3
  # Con el DMUB caido, HDMI-2 no llega a hacer scanout: X dibuja el escritorio
  # en el framebuffer pero el monitor no recibe senal. Reponemos el blob de la
  # ISO 26.05, que si arranca.
  #
  #   sha256: d2d57e22c89d55f9dd7a0bb7c7b4fe1f66a659cb0b82c652ba256f90f9097c6b
  #
  # mkBefore => este paquete va primero y gana la colision con linux-firmware
  # ("the first package in the list takes precedence", hardware.firmware).
  # compressFirmware = false porque el fichero ya viene comprimido en .zst.
  #
  # Comprobar tras reiniciar:  journalctl -k -b | grep -i dmcub
  # Quitar cuando linux-firmware vuelva a funcionar en esta GPU.
  hardware.firmware = lib.mkBefore [
    (pkgs.runCommand "amdgpu-dmcub-yellow-carp-fix"
      { passthru.compressFirmware = false; }
      ''
        mkdir -p $out/lib/firmware/amdgpu
        cp ${./firmware/amdgpu/yellow_carp_dmcub.bin.zst} \
           $out/lib/firmware/amdgpu/yellow_carp_dmcub.bin.zst
      '')
  ];
  # -------------------------------------------------------------------------

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. Leave it at the release
  # version of the first install of this system.
  system.stateVersion = "24.05";
}
