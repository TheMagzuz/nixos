{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./harpoon.nix
    ./telescope.nix
    ./surround.nix
    ./lsp.nix
    ./mini.nix
    ./octo.nix
    ./flash.nix
    ./rainbow-delimiters.nix
    ./snippets
  ];
  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      theme = {
        enable = true;
        name = "dracula";
      };
      options = {
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        signcolumn = "yes";
        ignorecase = true;
        smartcase = true;
        incsearch = true;
        title = true;
        completeopt = "menuone,noselect";
      };
      maps = {
        insert = {
          "jk" = {
            action = "<esc>";
            nowait = true;
          };
        };
        normal = {
          "<leader>n" = {
            action = "function() vim.cmd('noh') end";
            lua = true;
            desc = "disable highlights";
          };
        };
      };
      clipboard = {
        enable = true;
        registers = "unnamedplus";
      };
      git.enable = true;
      binds.whichKey.enable = true;
      visuals.fidget-nvim.enable = true;
      extraPlugins = with pkgs.vimPlugins; {
        vim-sleuth = {
          package = vim-sleuth;
        };
        vim-rhubarb = {
          package = vim-rhubarb;
        };
        vim-argumentative = {
          package = vim-argumentative;
        };
      };
      lazy.enable = true;
      extraLuaFiles = [
        ./yank_highlight.lua
      ];
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
