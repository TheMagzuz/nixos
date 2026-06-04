{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.nvf.settings.vim = {
    treesitter.grammars = builtins.filter lib.isDerivation (map (x: x.value) (lib.attrsToList pkgs.vimPlugins.nvim-treesitter.builtGrammars));
    lsp = {
      enable = true;
      formatOnSave = true;
      mappings = {
        goToDefinition = "gd";
        goToDeclaration = "gD";
        listImplementations = "gi";
        openDiagnosticFloat = "gl";
      };
      lspSignature.enable = true;
      lightbulb.enable = true;
      otter-nvim.enable = true;
      trouble.enable = true;
      servers.nixd.init_options = let
        flake = ''(builtins.getFlake "${inputs.self}")'';
      in {
        nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";
        nixos.expr = "${flake}.nixosConfigurations.vulpes.options";
      };
    };
    languages = {
      enableTreesitter = true;
      enableFormat = true;
      nix = {
        enable = true;
        lsp = {
          servers = ["nixd"];
        };
        extraDiagnostics = {
          enable = true;
          types = ["statix"];
        };
      };
      rust = {
        enable = true;
        extensions.crates-nvim.enable = true;
        lsp.opts = ''
          ['rust-analyzer'] = {
            cargo = {allFeatures = true},
            check = {command = "clippy"},
          },
        '';
      };
      typescript = {
        enable = true;
        extraDiagnostics.enable = true;
      };
      tsx = {
        enable = true;
        extraDiagnostics.enable = true;
      };
      lua.enable = true;
      haskell.enable = true;
      assembly.enable = true;
      csharp = {
        enable = true;
        extensions.roslyn-nvim.enable = true;
        lsp.servers = ["roslyn-ls"];
      };
      python = {
        enable = true;
        lsp.servers = ["pyright"];
      };
      html.enable = true;
      typst.enable = true;
      nu.enable = true;
      java.enable = true;
    };
    autocomplete.nvim-cmp = {
      enable = true;
      mappings = {
        next = "<c-n>";
        previous = "<c-p>";
      };
    };
    extraPlugins = {
      emmet-vim = {
        package = pkgs.vimPlugins.emmet-vim;
      };

      lean-nvim = {
        package = pkgs.vimPlugins.lean-nvim;
        setup = ''
          require('lean').setup{ mappings = true }
        '';
      };
    };
    # HACK: indentexpr is currently broken in C# files, so just disable it
    # See https://github.com/NotAShelf/nvf/issues/1339
    autocmds = [
      {
        event = ["BufEnter"];
        pattern = ["*.cs"];
        command = "setlocal indentexpr=\"\"";
      }
    ];
  };
}
