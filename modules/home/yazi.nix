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
  };

  home.shellAliases = {
    "yy" = "yazi";
  };
}
