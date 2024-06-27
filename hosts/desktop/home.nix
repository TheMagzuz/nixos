{ config, pkgs, lib, ...}:
{
  imports = [
    ../shared/home.nix
    ../../modules/nh.nix
    ../../modules/flatpak.nix
  ];
  custom.nh = {
    enableAliases = true;
    aliasHostname = "desktop";
  };
}
