{ config, pkgs, lib, ...}:
{
  programs.nvf.settings.vim.telescope = {
    enable = true;
    mappings = {
      findFiles = "<c-p>";
    };
  };
}
