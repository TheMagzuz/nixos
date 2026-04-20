{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPlugins = with pkgs.vimPlugins; {
      octo-nvim = {
        package = octo-nvim;
        setup = ''require"octo".setup()'';
      };
    };
  };
}
