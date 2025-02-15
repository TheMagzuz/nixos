{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nvf.settings.vim = {
    maps.normal = {
      "<c-n>" = {
        action = "MiniFiles.open";
        lua = true;
      };
    };
    mini = {
      files.enable = true;
      splitjoin.enable = true;
      indentscope.enable = true;
      trailspace.enable = true;
    };
  };
}
