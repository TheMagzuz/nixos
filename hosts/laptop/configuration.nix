{ ... }@inputs:
{
  imports = [
    ./gpu.nix
    ./hardware-configuration.nix
  ];
  networking.hostName = "vulpes";
}
