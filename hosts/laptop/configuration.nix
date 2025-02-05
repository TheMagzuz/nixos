{ ... }@inputs:
{
  imports = [
    ./gpu.nix
    ./hardware-configuration.nix
  ];
  networking.hostName = "vulpes";
  powerManagement.enable = true;
  services.tlp = {
    enable = true;
  };

  programs.light = {
    enable = true;
    brightnessKeys.enable = true;
  };
}
