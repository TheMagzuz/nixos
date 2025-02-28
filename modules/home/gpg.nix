{
  config,
  pkgs,
  ...
}: {
  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
  # required for pinentry-gnome3
  home.packages = [pkgs.gcr];

  programs.git.signing = {
    format = "openpgp";
    signByDefault = true;
  };
}
