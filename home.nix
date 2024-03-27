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
      gaa="git add -A";
      gc="git commit -m";
      gl="git log";
      gst="git status";
      gps="git push";
      gpl="git pull";
      gd="git diff";
      gap="git add -p";
      gpu="git push --set-upstream origin HEAD";
      gfl="git push --force-with-lease";
      gam="git commit --amend --no-edit";
      gsw="git switch";
      gsc="git switch -c";
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
      fd
      python3
  ];
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;
  };

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

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.gh.enable = true;
  programs.tmux.enable = true;
  programs.git.delta = {
    enable = true;
    options = {
      line-numbers = true;
      theme = "dracula";
      navigate = true;
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.bat.enable = true;
  programs.eza = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
  };

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
    package = pkgs.polybar.override {
      pulseSupport = true;
    };
  };

  services.dunst.enable = true;
}
