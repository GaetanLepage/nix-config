{ pkgs, ... }:

{
    services = {

        # Don’t shutdown when power button is short-pressed
        logind.extraConfig = ''
            HandlePowerKey=ignore
        '';

        xserver = {
            # Enable the X11 windowing system.
            enable = true;

            serverFlagsSection = ''
              Option "BlankTime" "0"
              Option "StandbyTime" "0"
              Option "SuspendTime" "0"
              Option "OffTime" "0"
            '';

            # Configure keymap in X11
            layout = "fr";

            # Enable touchpad support
            libinput.enable = true;

            # Whether to symlink the X server configuration under /etc/X11/xorg.conf
            exportConfiguration = true;

            displayManager.lightdm = {
                enable = true;

                greeters = {
                    gtk = {
                        enable = true;
                        theme = {
                            name = "Matcha-dark-aliz";
                            package = pkgs.matcha-gtk-theme;
                        };
                        cursorTheme = {
                            name = "Numix-Cursor-Light";
                            package = pkgs.numix-cursor-theme;
                        };
                    };
                };
            };

            windowManager.bspwm.enable = true;
        };
    };
}
