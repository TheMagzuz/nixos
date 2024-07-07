{ pkgs, config, lib, ... }:
let
cfg = config.custom.music;
in
{
  options.custom.music = {
    enable = lib.mkEnableOption "music services";
  };

  config = lib.mkIf cfg.enable {
    sops = {
      secrets = {
        "subsonic_url" = {};
        "subsonic_username" = {};
        "subsonic_password" = {};
        "scrobbler_username" = {};
        "scrobbler_password" = {};
      };

      templates."mopidy.conf" = {
        content = ''
          [scrobbler]
          password = ${config.sops.placeholder."scrobbler_password"}
          username = ${config.sops.placeholder."scrobbler_username"}

          [subidy]
          password = ${config.sops.placeholder."subsonic_password"}
          url = ${config.sops.placeholder."subsonic_url"}
          username = ${config.sops.placeholder."subsonic_username"}
        '';
        mode = "0440";
        owner = config.users.users.mopidy.name;
      };
    };
    services.mopidy = {
      enable = cfg.enable;
      extensionPackages = with pkgs; [
        mopidy-mpd
        mopidy-subidy
        mopidy-scrobbler
      ];
      extraConfigFiles = [ config.sops.templates."mopidy.conf".path ];
    };

  };

}
