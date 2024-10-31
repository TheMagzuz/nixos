{ config, pkgs, lib, ...}:
{
  imports = [
    ../shared/home.nix
  ];

  home.packages = with pkgs; [
    prismlauncher
  ];
}
