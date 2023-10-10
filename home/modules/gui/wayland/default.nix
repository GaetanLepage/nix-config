{pkgs, ...}: {
  imports = [
    ./foot.nix
    ./gammastep.nix
    ./kanshi.nix
    ./sway
    ./swaylock.nix
    ./waybar
  ];

  programs.rofi.package = pkgs.rofi-wayland;

  home.packages = with pkgs; [
    wdisplays
    wlr-randr
    wl-clipboard
    grim # needed by flameshot
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;

    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    XDG_SESSION_TYPE = "wayland";
  };

  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };
}
