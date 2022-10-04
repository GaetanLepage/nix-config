{ pkgs, ... }:

{
    services = {

        # Don’t shutdown when power button is short-pressed
        logind.extraConfig = ''
            HandlePowerKey=ignore
        '';

        xserver = {
            # Enable touchpad support
            libinput.enable = true;

            displayManager.lightdm = {
                enable = true;

                greeters.gtk = {
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

            windowManager.bspwm.enable = true;
        };
    };
}
