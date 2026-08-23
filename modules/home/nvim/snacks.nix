{
  programs.nvf.settings.vim = {
    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        bigfile = {enabled = true;};
        input = {enabled = true;};
        quickfile = {enabled = true;};
      };
    };
    luaConfigPre = ''
      if vim.env.PROF then
        require("snacks.profiler").startup({
          startup = {
            event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
            -- event = "UIEnter",
            -- event = "VeryLazy",
          },
        })
      end
    '';
    maps.normal = {
      "<leader>pp" = {
        action = "Snacks.toggle.profiler";
        lua = true;
        desc = "toggle profiler";
      };
      "<leader>ph" = {
        action = "Snacks.toggle.profiler_highlights";
        lua = true;
        desc = "toggle profiler highlights";
      };
      "<leader>ps" = {
        action = "Snacks.profiler.scratch";
        lua = true;
        desc = "profiler scratch buffer";
      };
    };
  };
}
