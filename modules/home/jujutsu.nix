{
  pkgs,
  lib,
  ...
}: {
  programs = {
    jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "magz";
          email = "magz@noreply.codeberg.org";
        };
      };
    };
    delta.enableJujutsuIntegration = true;
    starship = {
      extraPackages = [pkgs.jj-starship];
      settings = {
        custom.jj = {
          when = "${lib.getExe pkgs.jj-starship} detect";
          shell = [(lib.getExe pkgs.jj-starship)];
          format = "$output ";
        };
        git_branch.disabled = true;
        git_status.disabled = true;
        git_commit.disabled = true;
        format = "$directory\${custom.jj}$all";
      };
    };
  };
}
