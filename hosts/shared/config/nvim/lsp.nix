{ pkgs, lib, ... }:
let
    lspPlugin = { name, cmd ? null,  extraConfig ? "{}" }:
        let
        argsList = (if builtins.isList cmd then cmd else [cmd]);
        argsStr = builtins.concatStringsSep ", " (map (arg: "'${arg}'") argsList);
        setupArgs = if cmd != null then "{ cmd = { ${argsStr} } }" else "{}"; in ''
        do
            local setupArgs = ${setupArgs}
            local extraArgs = ${extraConfig}
            for k,v in pairs(extraArgs) do setupArgs[k] = v end
            require'lspconfig'.${name}.setup(setupArgs)
        end
    '';
    lspPlugins = plugins: builtins.concatStringsSep "\n" (map lspPlugin plugins);
in
with pkgs.vimPlugins; [
    {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./luacfg/plugin/lspconfig.lua + "\n" + (lspPlugins [
            {
                name = "rust_analyzer";
                cmd = "${pkgs.rust-analyzer}/bin/rust-analyzer";
                extraConfig = ''
                {
                    settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = {
                          allFeatures = true,
                          command = "clippy",
                          extraArgs = {
                            "--",
                            "--no-deps",
                            "-Dclippy::correctness",
                            "-Dclippy::complexity",
                            "-Wclippy::perf",
                            "-Wclippy::pedantic",
                          },
                        },
                    }
                    },
                }
                '';
            }

            {
                name = "nil_ls";
                cmd = "nil";
            }

            {
                name = "texlab";
                cmd = "${pkgs.texlab}/bin/texlab";
            }

            {
                name = "csharp_ls";
                cmd = "${pkgs.csharp-ls}/bin/csharp-ls";
                # extraConfig = ''
                #     {
                #         enable_roslyn_analyzers = true,
                #         enable_import_completion = true,
                #     }
                # '';
            }

            {
                name = "hls";
                cmd = ["haskell-language-server-wrapper" "--lsp"];
            }

            {
                name = "denols";
                cmd = [ "deno" "lsp" ];
            }

            {
                name = "pyright";
            }
        ]);
    }

    {
        plugin = neodev-nvim;
        type = "lua";
        config = builtins.readFile ./luacfg/plugin/neodev.lua;
    }
    # autocompletion
    {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./luacfg/plugin/cmp.lua;
    }
    cmp-buffer
    cmp-path
    cmp_luasnip
    cmp-nvim-lua
    cmp-nvim-lsp

    # Debugger
    {
        plugin = nvim-dap;
        type = "lua";
        config = builtins.readFile ./luacfg/plugin/dap.lua;
    }
    nvim-dap-ui # UI for Debugger

]
