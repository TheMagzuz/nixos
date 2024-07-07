{ pkgs, config, lib, ... }:
let
cfg = config.custom.music;
in
{
  options.custom.music = {
    enable = lib.mkEnableOption "music services";
  };

  config = lib.mkIf cfg.enable {
    services.mopidy = {
      enable = cfg.enable;
      extensionPackages = with pkgs; [
        mopidy-mpd
        mopidy-subidy
        mopidy-scrobbler
      ];
      configuration = ''
        [mpd]
        enabled = true;
      '';
      extraConfigFiles = [ config.sops.templates."mopidy.conf".path ];
    };

  };

}
