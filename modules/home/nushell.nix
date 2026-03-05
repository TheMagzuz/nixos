{pkgs, ...}: {
  home.shell.enableNushellIntegration = true;
  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [
      query
    ];
    settings = {
      buffer_editor = "nvim";
      edit_mode = "vi";
      show_banner = false;
    };
    shellAliases = {
      "fg" = "job unfreeze";
    };
    extraConfig = ''
      def nix-init [] {
        nix flake init --template templates#utils-generic
        direnv allow
      }

      def root-sizes [] {
        ^find /nix/var/nix/gcroots/ -type l -readable | xargs nix path-info -S | detect columns --no-headers | rename path size | update size {into filesize} | sort-by size
      }
    '';
  };

  # enable carapace for shell completions
  programs.carapace.enable = true;
}
