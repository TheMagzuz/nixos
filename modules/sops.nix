{ pkgs, config, lib, ... }:
{
  sops = {
    defaultSopsFile = ../secrets/secrets.json;
    defaultSopsFormat = "json";

    age.keyFile = "/home/markus/.config/sops/age/keys.txt";

    secrets = {
      "subsonic_url" = {};
      "subsonic_username" = {};
      "subsonic_password" = {};
      "scrobbler_username" = {};
      "scrobbler_password" = {};
    };

    templates."mopidy.conf".content = ''
      [scrobbler]
      password = ${config.sops.placeholder."scrobbler_password"}
      username = ${config.sops.placeholder."scrobbler_username"}

      [subidy]
      password = ${config.sops.placeholder."subsonic_password"}
      url = ${config.sops.placeholder."subsonic_url"}
      username = ${config.sops.placeholder."subsonic_username"}
    '';
  };
}
