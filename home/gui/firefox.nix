{
    programs.firefox = {
        enable = true;

        profiles = {
            gaetan = {
                id = 0;
                isDefault = true;
                path = "gaetan";
                settings = {
                    # Needed to hide the tab bar
                    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                };

                # Hide the tab bar
                userChrome = ''
                    #TabsToolbar { visibility: collapse !important; }
                '';
            };

            lcf = {
                id = 1;
                isDefault = false;
                path = "lcf";
                settings = {
                    # Needed to hide the tab bar
                    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                };

                # Hide the tab bar
                userChrome = ''
                    #TabsToolbar { visibility: collapse !important; }
                '';
            };
        };
    };
}
