{
  lib,
  pkgs,
  config,
}:
let
  dunstctl = lib.getExe' config.services.dunst.package "dunstctl";
in
{
  interval = 1;

  # Disable hover
  tooltip = false;
  return-type = "json";

  exec = pkgs.writeShellScript "dunst-waybar" ''

    if [ "$(${dunstctl} is-paused)" == "true" ]; then
        echo '{"class": "off", "text": " "}'
    else
        echo '{"class": "on", "text": " "}'
    fi
  '';

  on-click = "${dunstctl} set-paused toggle";
}
