{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.custom.man;
in {
  options.custom.man = {
    enable = mkEnableOption "man pages";
  };

  config = mkIf cfg.enable {
    documentation.dev.enable = true;
    environment.systemPackages = with pkgs; [
      man-pages
      man-pages-posix
    ];
  };
}
