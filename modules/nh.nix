{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.custom.nh;
  nhCmd = "${config.home.profileDirectory}/bin/nh";
in {
  options.custom.nh = {
    enable = mkEnableOption "nh";
    flake = mkOption {
      type = types.nullOr types.path;
      default = config.home.homeDirectory + "/flake";
      description = ''
        The path that will be used for the `FLAKE` environment variable.

        `FLAKE` is used by nh as the default flake for performing actions, like `nh os switch`.
      '';
    };
    enableZshIntegration = mkEnableOption "Zsh integration" // {
      default = true;
    };
    enableAliases = mkEnableOption "switch and test shell aliases";
    package = mkPackageOption pkgs "nh" { };
  };

  config = mkIf cfg.enable {
    assertions = [
          {
            assertion = (cfg.flake != null) -> !(lib.hasSuffix ".nix" cfg.flake);
            message = "nh.flake must be a directory, not a nix file";
          }
    ];
    home = {
      packages = [ cfg.package ];
      sessionVariables = mkIf (cfg.flake != null) {
        FLAKE = cfg.flake;
      };
      shellAliases = {
        nh-test = "nh os test -- -j8 --cores 8";
        nh-switch = "nh os switch -- -j8 --cores 8";
      };
    };
    programs.zsh.initExtra = mkIf cfg.enableZshIntegration ''
      if [[ $TERM != "dumb" ]]; then
        eval "$(${nhCmd} completions --shell zsh)"
      fi
    '';

  };
}
