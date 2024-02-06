{ config, pkgs, lib, ... }:
{
  home.username = "markus";
  home.homeDirectory = "/home/markus";
  home.stateVersion = "23.11";

  home.shellAliases = {
      nixcfg = "nvim ~/flake/configuration.nix";
      homecfg = "nvim ~/flake/home.nix";
      flakecfg = "nvim ~/flake/flake.nix";
      nix-switch = "sudo nixos-rebuild switch --flake ~/flake#nixos";
      nix-test = "sudo nixos-rebuild test --flake ~/flake#nixos";
      gaa="git add .";
      gc="git commit -m";
      gl="git log";
      gst="git status";
      gps="git push";
      gpl="git pull";
      gd="git diff";
      gap="git add -p";
  };

  home.pointerCursor = {
    name = "Adwaita";
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.gnome.adwaita-icon-theme;
  };

  gtk = {
    enable = true;
  };
  
  home.packages = with pkgs; [
      discord
      xss-lock
      unzip
      maim
      xclip
      arandr
      pulsemixer
      zathura
      bc
      units
      ripgrep
      pulseaudio
      texlive.combined.scheme-full
      pandoc
      lf
      pdfgrep
      obsidian
      vscode
  ];
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;
  };

  # TODO: set this up
  programs.neovim =  import ./config/nvim { inherit pkgs lib; };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.kitty = {
    enable = true;
    theme = "Dracula";
  };

  programs.git = {
    enable = true;
    userName = "Markus Dam";
    userEmail = "markus.dam123@gmail.com";
  };

  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.resistFingerprinting" = false;
    };
  };

  programs.rofi = {
    enable = true;
    theme = "dracula";
    terminal = "kitty";
    extraConfig = {
      modes = "drun,run";
      sidebar-mode = true;
    };
  };

  programs.gh.enable = true;
  programs.tmux.enable = true;

  # Setup i3wm
  xsession = {
    enable = true;
    windowManager.i3.enable = true;
    windowManager.i3.config = import ./config/i3.nix { inherit pkgs lib; };
  };


  services.polybar = {
    enable = true;
    settings = import ./config/polybar.nix;
    script = "polybar top &";
  };

  services.dunst.enable = true;
}
