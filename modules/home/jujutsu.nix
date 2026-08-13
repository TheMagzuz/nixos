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
        revset-aliases = {
          "closest_pushable(to)" = {
            definition = "heads(::to & mutable() & ~empty() & description(regex:\".+\"))";
            doc = "Closest mutable, non-empty, described commits at or behind to";
          };
        };
        revsets = {
          "bookmark-advance-to" = "closest_pushable(@)";
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
