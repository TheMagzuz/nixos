{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./monitors.nix
    ./gpu.nix
    # ../../modules/flatpak.nix
  ];

  networking.hostName = "lupus";

  musnix = {
    enable = true;
    soundcardPciId = "00:1f.3";
  };
  environment.systemPackages = with pkgs; [
    surge-XT
    bitwig-studio
  ];
}
