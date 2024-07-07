{ config, pkgs, lib, ...}:
{
  imports = [
    ../shared/home.nix
    ../../modules/nh.nix
  ];
  custom.nh = {
    enableAliases = true;
    aliasHostname = "desktop";
  };
}
