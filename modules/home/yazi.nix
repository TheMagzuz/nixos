{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "yy";
    flavors = let
      flavor-repo = pkgs.fetchFromGitHub {
        owner = "yazi-rs";
        repo = "flavors";
        rev = "0f9204bc948c8313963f5c9d571a82edc201f8aa";
        hash = "sha256-qWNArjWuxWL+rOjLzyIniW5hJgWiAWTCgXmMXJpaWZE=";
      };
    in {
      dracula = "${flavor-repo}/dracula.yazi";
    };
    theme.flavor.dark = "dracula";
    plugins = {
      inherit
        (pkgs.yaziPlugins)
        smart-enter
        jump-to-char
        ;
    };
    keymap = {
      mgr.prepend_keymap = [
        {
          on = ["f"];
          run = "plugin jump-to-char";
          desc = "Jump to char";
        }
        {
          on = ["l"];
          run = "plugin smart-enter";
          desc = "Enter the child directory, or open the file";
        }
        {
          on = ["d"];
          run = "yank --cut";
          desc = "Yank selected files (cut)";
        }
        {
          on = ["u"];
          run = "unyank";
          desc = "Cancel the yank status";
        }
        {
          on = ["D"];
          run = "remove";
          desc = "Trash selected files";
        }
      ];
    };
  };
}
