_: {
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  services.home-manager.autoExpire = {
    enable = true;
    frequency = "weekly";
    timestamp = "-14 days";
  };
}
