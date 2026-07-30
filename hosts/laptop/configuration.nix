_: {
  imports = [
    ./gpu.nix
    ./hardware-configuration.nix
  ];
  networking.hostName = "vulpes";
  powerManagement.enable = true;
  services.tlp = {
    enable = true;
  };

  services.xserver.xkb.options = "caps:swapescape";

  hardware.acpilight.enable = true;
  users.users."magz".extraGroups = ["video"];
}
