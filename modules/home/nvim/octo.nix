{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPlugins = with pkgs.vimPlugins; {
      octo-nvim = {
        package = octo-nvim.overrideAttrs (prev: {
          dependencies = prev.dependencies ++ [nvim-web-devicons];
        });
        setup = ''require"octo".setup()'';
      };
    };
  };
}
