{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.nvf.settings.vim = {
    treesitter.grammars = builtins.filter lib.isDerivation (builtins.map (x: x.value) (lib.attrsToList pkgs.vimPlugins.nvim-treesitter.builtGrammars));
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
    };
    languages = {
      enableTreesitter = true;
      enableFormat = true;
      nix = {
        enable = true;
        lsp = {
          server = "nixd";
          options = let
            flake = ''(builtins.getFlake "${inputs.self}")'';
          in {
            nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";
            nixos.expr = "${flake}.nixosConfigurations.vulpes.options";
          };
        };
        extraDiagnostics = {
          enable = true;
          types = ["statix"];
        };
      };
      rust = {
        enable = true;
        crates.enable = true;
      };
      ts.enable = true;
      lua.enable = true;
      haskell.enable = true;
      assembly.enable = true;
      csharp = {
        enable = true;
        lsp.enable = false;
      };
      python = {
        enable = true;
        lsp.server = "pyright";
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

      roslyn-nvim = {
        package = pkgs.vimPlugins.roslyn-nvim.overrideAttrs {
          version = "2025-04-25";
          src = pkgs.fetchFromGitHub {
            owner = "seblyng";
            repo = "roslyn.nvim";
            rev = "353bc0f30076b82d027a554229995f1e0fa1c5e1";
            hash = "sha256-BCjmt1XjfTeSNWWwnxStMFRpZUTlT+b9tuTUATRuzT0=";
          };
        };
        setup = ''
          require("roslyn").setup({
              config = {
                  cmd = {
                      "${pkgs.dotnetCorePackages.runtime_9_0}/bin/dotnet",
                      "${pkgs.roslyn-ls}/lib/roslyn-ls/Microsoft.CodeAnalysis.LanguageServer.dll",
                      "--logLevel=Information",
                      "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
                      "--stdio",
                  },
                  on_attach = default_on_attach,
              },
          })
        '';
      };

      lean-nvim = {
        package = pkgs.vimPlugins.lean-nvim;
        setup = ''
          require('lean').setup{ mappings = true }
        '';
      };
    };
  };
}
