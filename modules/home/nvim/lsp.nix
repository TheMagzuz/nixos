{
  inputs,
  pkgs,
  ...
}: {
  programs.nvf.settings.vim = {
    lsp = {
      enable = true;
      lspconfig = {
        enable = true;
      };
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
      enableLSP = true;
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
    };
    autocomplete.nvim-cmp = {
      enable = true;
      mappings = {
        next = "<c-n>";
        previous = "<c-p>";
      };
    };
  };
}
