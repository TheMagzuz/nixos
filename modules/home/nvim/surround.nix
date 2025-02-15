{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nvf.settings.vim.utility.surround = {
    enable = true;
    useVendoredKeybindings = false;
  };
}
