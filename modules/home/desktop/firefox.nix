{
  flake.modules.homeManager.firefox =
    { pkgs, ... }:
    {
      programs.firefox = {
        enable = true;

        # TODO Firefox fails as the closure contains a reference to stdenv.cc
        # Relax this assertion until the underlying issue is fixed
        # https://github.com/NixOS/nixpkgs/pull/457424
        package = pkgs.firefox.overrideAttrs { disallowedRequisites = [ ]; };

        profiles =
          let
            settings = {
              # Needed to hide the tab bar
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

              # Prevent tabbing on the "3 dot menu" on Firefox Suggest drop down items
              # https://connect.mozilla.org/t5/discussions/how-to-remove-the-3-dot-menu-on-firefox-suggest-drop-down-items/td-p/28339
              "browser.urlbar.resultMenu.keyboardAccessible" = false;
            };

            # Hide the tab bar
            userChrome = ''
              #TabsToolbar { visibility: collapse !important; }
            '';
          in
          {
            gaetan = {
              id = 0;
              isDefault = true;
              path = "gaetan";
              inherit
                settings
                userChrome
                ;
            };

            lcf = {
              id = 1;
              isDefault = false;
              path = "lcf";
              inherit
                settings
                userChrome
                ;
            };
          };
      };
    };
}
