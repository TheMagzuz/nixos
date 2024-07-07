{ pkgs, config, lib, ... }:
{
  sops = {
    defaultSopsFile = ../secrets/secrets.json;
    defaultSopsFormat = "json";

    age.keyFile = "/home/markus/.config/sops/age/keys.txt";
  };
}
