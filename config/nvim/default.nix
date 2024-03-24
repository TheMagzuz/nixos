{ pkgs, lib, ... }:
{
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = let
        luaCfg = config: "lua << EOF\n" + config + "\nEOF";
    in
    with pkgs.vimPlugins; [
        telescope-nvim
        dracula-nvim
        nvim-treesitter.withAllGrammars
        # git plugins
        vim-fugitive
        vim-rhubarb

        # symbols in the gutter and git utilities
        {
          plugin = gitsigns-nvim;
          config = luaCfg (lib.strings.fileContents ./luacfg/plugin/gitsigns.lua);
        }

        # comment lines with "gc"
        comment-nvim

        # detect tabstop and shiftwidth automatically
        vim-sleuth

        # status notifications
        fidget-nvim

        # show pending keybinds
        which-key-nvim

        vim-repeat
        vim-surround


        # lsp-zero dependencies
        lsp-zero-nvim
        # lsp support
        nvim-lspconfig

        # inline function call signature hints
        lsp_signature-nvim

        # autocompletion
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp_luasnip
        cmp-nvim-lua
        cmp-nvim-lsp

        formatter-nvim
        luasnip
        harpoon
        neodev-nvim
        trouble-nvim
        nerdtree
        vimtex
    ];
    extraLuaConfig = builtins.concatStringsSep "\n" ((map lib.strings.fileContents (import ./luacfg)) ++ [

    ]);
    extraPackages = with pkgs; [
        rust-analyzer
        lua-language-server
        nil
        texlab
    ];
}
