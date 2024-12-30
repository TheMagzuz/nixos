{ ... }@inputs:
{
  imports = [
    ./hardware-configuration.nix
    ./monitors.nix
    ./gpu.nix
    # ../../modules/flatpak.nix
  ];
  custom.music.enable = true;

  networking.hostName = "lupus";
}
