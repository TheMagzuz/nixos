{pkgs, ...}: {
  # programs.nvf.settings.vim.visuals.rainbow-delimiters = {
  #   enable = true;
  # };
  programs.nvf.settings.vim.extraPlugins = {
    rainbow-delimiters = {
      package = pkgs.vimUtils.buildVimPlugin {
        pname = "rainbow-delimiters";
        version = "0.9.1";
        src = pkgs.fetchFromGitHub {
          owner = "HiPhish";
          repo = "rainbow-delimiters.nvim";
          rev = "49372aadaaf04d14a50efaa34150c51d5a8047e1";
          hash = "sha256-qvYpFcqLJ/DCdgGUaeaEOna9J9Rcsnj98OQr1ioINiI=";
        };
        nvimSkipModules = [
          # rainbow-delimiters.types.lua
          "rainbow-delimiters.types"
          # Test that requires an unpackaged dependency
          "rainbow-delimiters._test.highlight"
        ];
      };
    };
  };
}
