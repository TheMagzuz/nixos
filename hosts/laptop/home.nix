{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../shared/home.nix
    ./gpg.nix
  ];
}
