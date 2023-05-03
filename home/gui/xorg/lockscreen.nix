{pkgs, ...}: {
  home.packages = [pkgs.betterlockscreen];

  # Run: `betterlockscreen -u ~/config/home/gui/wallpaper.svg`

  xdg.configFile.betterlockscreenrc.text = ''
    lock_timeout=0
    fx_list=()

    locktext=""
  '';
}
