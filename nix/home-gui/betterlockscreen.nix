{ pkgs, config, ... }:

{
    home.packages = [ pkgs.betterlockscreen ];

    xdg.configFile.betterlockscreenrc.text = ''
        lock_timeout=0
        fx_list=()
        wallpaper_cmd="xwallpaper --zoom ${config.xdg.dataFile.wallpaper.target}"

        locktext=""
    '';
}
