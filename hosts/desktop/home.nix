{ config, pkgs, lib, ...}:
{
  imports = [
    ../shared/home.nix
  ];

  home.packages = with pkgs; [
    prismlauncher
    bolt-launcher
  ];

  xsession.windowManager.i3.config.workspaceOutputAssign = (map (i: {
    workspace = toString i;
    output = if (lib.trivial.mod i 2) == 0 then "HDMI-0" else "DP-0";
  }) (lib.lists.range 1 9));
}
