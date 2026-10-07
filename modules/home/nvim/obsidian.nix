{lib, ...}: {
  programs.nvf.settings.vim = {
    notes.obsidian = {
      enable = true;
      setupOpts = {
        legacy_commands = false;
        workspaces = [
          {
            name = "notes";
            path = "~/notes";
          }
        ];
        attachments.folder = "/images";
        checkbox.create_new = false;
        footer.enabled = false;
        note.template = lib.mkLuaInline "vim.NIL";
        note_id_func = lib.mkLuaInline ''
          function(base, dir)
            if not dir then
              return base
            end

            local Path = require "obsidian.path"
            local base_dir = Path.new(dir)
            local candidate = base
            local idx = 2

            while (base_dir / candidate):with_suffix(".md", true):exists() do
              candidate = string.format("%s-%d", base, idx)
              idx = idx + 1
            end

            return candidate
          end'';
      };
    };
    keymaps = let
      mkNMap = key: action: {
        inherit key action;
        mode = ["n"];
        silent = true;
      };
      mkObsidianMap = key: action: mkNMap ("<leader>o" + key) ("<cmd>" + action + "<cr>");
    in [
      (mkNMap "<leader>fn" "<cmd>Obsidian quick_switch<cr>")
      (mkObsidianMap "n" "Obsidian new")
    ];
    options = {
      conceallevel = 2;
      foldlevelstart = 99;
    };
  };
}
