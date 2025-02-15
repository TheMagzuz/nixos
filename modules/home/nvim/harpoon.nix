{ config, pkgs, lib, ...}:
{
  programs.nvf.settings.vim.lazy.plugins = with pkgs.vimPlugins; {
    harpoon2 = {
      enabled = true;
      package = harpoon2;
      setupModule = "harpoon";
      keys =
        [{
          mode = "n";
          key = "<leader>a";
          action = "function() require('harpoon'):list():add() end";
          lua = true;
          desc = "add current buffer to harpoon";
        }
        {
          mode = "n";
          key = "<c-e>";
          action = ''
            function()
              local h = require('harpoon')
              h.ui:toggle_quick_menu(h:list())
            end
            '';
          lua = true;
          desc = "show harpoon list";
        }] ++
        (pkgs.lib.lists.imap1 (i: x: {
           mode = "n";
           key = x;
           action = "function() require('harpoon'):list():select(${toString i}) end";
           lua = true;
        }) ["<c-s>" "<c-q>" "<c-l>" "<c-h>"]);
    };
  };
}
