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
          "top(of)" = {
            definition = "heads(of::)";
            doc = "Children of `of` that have no children of their own";
          };
        };
        revsets = {
          "bookmark-advance-to" = "closest_pushable(@)";
        };
        aliases = {
          "head" = {
            # We don't just do `top(@)` to account for situations such as
            # C
            # |
            # B @
            # |/
            # A
            # Here we want to edit `C`, but `top(@)` would be `@`.
            definition = ["edit" "-r" "top(@-) ~ @"];
            doc = "Edit the head of the current branch. This is the heads of `@-`, excluding `@`.";
          };
        };
        signing = {
          behavior = "own";
          backend = "gpg";
          key = "0x465204693EB08329";
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
