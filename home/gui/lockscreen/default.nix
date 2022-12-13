{ pkgs, config, ... }:

{
    home.packages = [ pkgs.betterlockscreen ];

    xdg = {

        # Run: `betterlockscreen -u ~/.local/share/lockscreen.svg`
        dataFile.lockscreen = {
            source = ./lockscreen.svg;
            target = "lockscreen.svg";
        };

        configFile.betterlockscreenrc.text = ''
            lock_timeout=0
            fx_list=()

            locktext=""
        '';
    };
}
