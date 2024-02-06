{ pkgs, lib, ... }:
{
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
        telescope-nvim
        dracula-nvim
        nvim-treesitter.withAllGrammars
        vim-fugitive
        vim-repeat
        vim-surround
        vim-gitgutter

        # lsp-zero dependencies
        lsp-zero-nvim
        # lsp support
        nvim-lspconfig
        mason-nvim
        mason-lspconfig-nvim
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
}
