{
  flake.modules.homeManager.wayland =
    { pkgs, ... }:
    {
      home = {
        packages = with pkgs; [
          wdisplays
          wlr-randr
          wl-clipboard
        ];

        sessionVariables = {
          # Unset NIXOS_OZONE_WL fixes flickering Discord on sway+Nvidia
          # https://discourse.nixos.org/t/nvidia-sway-flickering/65262/18
          # NIXOS_OZONE_WL = 1;

          SDL_VIDEODRIVER = "wayland";
          QT_QPA_PLATFORM = "wayland";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          _JAVA_AWT_WM_NONREPARENTING = "1";
          XDG_SESSION_TYPE = "wayland";
        };
      };
    };
}
