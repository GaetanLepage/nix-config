{
  "sway/workspaces" = import ./workspaces.nix;

  # imports = [
  #   ./workspaces.nix
  #
  #   # ./spotify.nix
  #   ./sway-window.nix
  #
  #   ./backlight.nix
  #   # ./sound.nix
  #   # ./ram.nix
  #   # ./cpu.nix
  #   # ./wifi.nix
  "battery" = {
    format = "{capacity}% {icon}";
    format-icons = ["" "" "" "" ""];
  };
  #   # ./clock.nix
  #   # ./date.nix
  #   # ./vpn.nix
  #   # ./notifs.nix
  # ];
  # sound
}
