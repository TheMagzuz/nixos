{ pkgs, config, lib, ... }:
{
  sops = {
    defaultSopsFile = ../secrets/secrets.json;
    defaultSopsFormat = "json";

    age.keyFile = "/home/magz/.config/sops/age/keys.txt";
  };
}
