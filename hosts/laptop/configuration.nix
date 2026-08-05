_: {
  imports = [
    ./gpu.nix
    ./hardware-configuration.nix
    ../../modules/podman.nix
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
