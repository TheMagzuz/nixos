{ ... }@inputs:
{
  imports = [
    ./hardware-configuration.nix
    ./monitors.nix
    ./gpu.nix
    ../../modules/flatpak.nix
  ];
}
