{
  flake.modules.homeManager.firefox = {
    programs.firefox = {
      enable = true;

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
