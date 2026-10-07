{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPlugins = {
      teamtype = {
        package = pkgs.vimPlugins.teamtype;
      };
    };
  };
  home.packages = [pkgs.teamtype];
}
