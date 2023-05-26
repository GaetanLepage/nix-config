{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./bspwm
    ./keyboard.nix
    ./kitty.nix
    ./lockscreen.nix
    ./picom.nix
    ./polybar
    ./sxhkd.nix
  ];

  home = {
    packages = with pkgs; [
      arandr
      mons

      # Helpers
      xclip
    ];

    sessionVariables = {
      XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
    };
  };
}
