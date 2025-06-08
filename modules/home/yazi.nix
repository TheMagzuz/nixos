{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    flavors = let
      flavor-repo = pkgs.fetchFromGitHub {
        owner = "yazi-rs";
        repo = "flavors";
        rev = "68326b4ca4b5b66da3d4a4cce3050e5e950aade5";
        hash = "sha256-nhIhCMBqr4VSzesplQRF6Ik55b3Ljae0dN+TYbzQb5s=";
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
      manager.prepend_keymap = [
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
          run = "Remove";
          desc = "Trash selected files";
        }
      ];
    };
  };
}
