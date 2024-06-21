# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./modules/man.nix
    ];

  

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
    

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # Automatically optimize nix store
  nix.optimise.automatic = true;

  # Automatically delete generations more than 30 days old every week
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Make obsidian work
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.markus = {
    isNormalUser = true;
    description = "Markus Dam";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
    ];
  };
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable experimental features that aren't really experimental
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     git
     libnotify
  ];

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "FiraCode Nerd Font Mono" ];
      };
    };
  };

  programs.dconf.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "eu";
      variant = "";
    };
  };

  services.libinput = {
      enable = true;
      mouse.accelProfile = "flat";
  };

  # make dynamically linked binaries work without patching
  programs.nix-ld.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.jdk11;
  };

  environment.etc = with pkgs; {
    "jdk11".source = jdk11;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Allow firmware updates
  services.fwupd.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable fingerprint scanner
  services.fprintd.enable = true;

  # enable virtualization
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  programs.steam.enable = true;

  security.pam.services = {
    login.fprintAuth = true;
    sudo.fprintAuth = true;
  };

  custom.man.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
