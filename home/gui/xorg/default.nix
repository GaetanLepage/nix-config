{pkgs, ...}: {
  imports = [
    ./bspwm
    ./keyboard.nix
    ./kitty.nix
    ./lockscreen.nix
    ./picom.nix
    ./polybar
    ./sxhkd.nix
  ];

  home.packages = with pkgs; [
    arandr
    mons

    # Helpers
    xclip
  ];
}
