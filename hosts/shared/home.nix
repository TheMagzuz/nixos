{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/home/i3.nix
    ../../modules/home/gpg.nix
    ../../modules/home/yazi.nix
    ../../modules/home/nvim
  ];
  home.username = "magz";
  home.homeDirectory = "/home/magz";
  home.stateVersion = "23.11";

  home.shellAliases = {
    nixcfg = "nvim ~/flake/configuration.nix";
    homecfg = "nvim ~/flake/home.nix";
    flakecfg = "nvim ~/flake/flake.nix";
    nix-switch = "sudo nixos-rebuild switch --flake ~/flake#nixos -j8";
    nix-test = "sudo nixos-rebuild test --flake ~/flake#nixos -j8";
    nix-init = "nix flake init --template templates\#utils-generic && direnv allow";
    gaa = "git add -A";
    gc = "git commit -m";
    gl = "git log";
    gst = "git status";
    gps = "git push";
    gpl = "git pull";
    gd = "git diff";
    gap = "git add -p";
    gpu = "git push --set-upstream origin HEAD";
    gfl = "git push --force-with-lease";
    gam = "git commit --amend --no-edit";
    gsw = "git switch";
    gsc = "git switch -c";
    gia = "git add -A --intent-to-add";
    nh-test = "nh os test -- -j8 --cores 8";
    nh-switch = "nh os switch -- -j8 --cores 8";
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
    # (pkgs.discord.override {
    # withVencord = true;
    #   withOpenASAR = true;
    # })
    vesktop
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
    obsidian
    fd
    python3
    zotero
    file
    sxiv
    codeberg-cli
    bacon
  ];
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    syntaxHighlighting.enable = true;
  };

  home.shell.enableZshIntegration = true;

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
    font = {
      name = "FiraCode Nerd Font Mono";
      size = 14;
    };
  };

  programs.git = {
    enable = true;
    userName = "magz";
    userEmail = "magz@noreply.codeberg.org";
    extraConfig = {
      init.defaultBranch = "main";
    };
    includes = [
      {
        condition = "hasconfig:remote.*.url:https://github.com/**";
        contents = {
          user.email = "11150183+TheMagzuz@users.noreply.github.com";
        };
      }
    ];
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

  programs.nh = {
    enable = true;
    flake = config.home.homeDirectory + "/flake";
  };

  # Setup i3wm
  xsession = {
    enable = true;
  };

  services.polybar = {
    enable = true;
    settings = import ./config/polybar.nix;
    script = ''
      PATH=$PATH:${lib.makeBinPath [pkgs.coreutils]}
      polybar --list-monitors | while read -r line; do
          m=$(echo "$line" | cut -d":" -f1)
          MONITOR=$m polybar --reload top &
      done
    '';
    package = pkgs.polybar.override {
      pulseSupport = true;
    };
  };

  services.dunst = {
    enable = true;
  };

  # manually write the dunst config since it's a big annoying file that i don't feel like converting
  # stolen from https://github.com/nix-community/home-manager/blob/7b9ece1bf3c8780cde9b975b28c2d9ccd7e9cdb9/modules/services/dunst.nix
  xdg.configFile."dunst/dunstrc" = {
    source = ./config/dunstrc;
    onChange = ''
      ${pkgs.procps}/bin/pkill -u "$USER" ''${VERBOSE+-e} dunst || true
    '';
  };
}
