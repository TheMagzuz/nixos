{pkgs, ...}: {
  home.packages = [pkgs.devenv];
  programs.nushell.extraConfig = let
    devShellHook =
      pkgs.runCommand "devShellHook" {
        nativeBuildInputs = [pkgs.devenv];
      } ''
        devenv hook nu > $out
      '';
  in ''
    source ${devShellHook}
  '';
}
