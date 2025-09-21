{pkgs, ...}: {
  home.shell.enableNushellIntegration = true;
  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [
      query
      highlight
    ];
    settings = {
      buffer_editor = "nvim";
      edit_mode = "vi";
      show_banner = false;
    };
    extraConfig = ''
      def nix-init [] {
        nix flake init --template templates\#utils-generic
        direnv allow
      }
    '';
  };
}
