{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/nh.nix
  ];
  home.username = "markus";
  home.homeDirectory = "/home/markus";
  home.stateVersion = "23.11";

  home.shellAliases = {
      nixcfg = "nvim ~/flake/configuration.nix";
      homecfg = "nvim ~/flake/home.nix";
      flakecfg = "nvim ~/flake/flake.nix";
      nix-switch = "sudo nixos-rebuild switch --flake ~/flake#nixos -j8";
      nix-test = "sudo nixos-rebuild test --flake ~/flake#nixos -j8";
      nix-init = "nix flake init --template templates\#utils-generic && direnv allow";
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
      gia="git add -A --intent-to-add";
  };

  home.pointerCursor = {
    name = "Adwaita";
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.adwaita-icon-theme;
  };

  gtk = {
    enable = true;
  };
  
  home.packages = with pkgs; [
      (pkgs.discord.override {
        withVencord = true;
        withOpenASAR = true;
      })
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
      pandoc
      lf
      obsidian
      fd
      python3
      zotero
      file
      sxiv
  ];
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
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
    themeFile = "Dracula";
    keybindings = {
      "ctrl+shift+enter" = "new_os_window_with_cwd";
    };
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
    theme = ./config/dracula.rasi;
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
    git = true;
    icons = "auto";
  };

  custom.nh.enable = true;

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

  services.dunst = {
    enable = true;
    configFile = ./config/dunstrc;
  };
}
