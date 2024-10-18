{ config, pkgs, lib, ...}:
{
  imports = [
    ../shared/home.nix
    ../../modules/nh.nix
  ];
}
