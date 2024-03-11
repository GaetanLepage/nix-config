{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./foot.nix
    ./gammastep.nix
    # ./hyprland
    ./kanshi.nix
    ./sway
    ./waybar
  ];

  options = {
    wallpaper = lib.mkOption {
      type = lib.types.str;
      default = builtins.toString ./wallpaper.png;
    };
  };

  config = {
    programs.rofi.package = pkgs.rofi-wayland;

    home = {
      packages = with pkgs; [
        wdisplays
        wlr-randr
        wl-clipboard
        grim # needed by flameshot
      ];

      sessionVariables = {
        NIXOS_OZONE_WL = 1;

        SDL_VIDEODRIVER = "wayland";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        _JAVA_AWT_WM_NONREPARENTING = "1";
        XDG_SESSION_TYPE = "wayland";
      };
    };
  };
}
