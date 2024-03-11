{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.hypridle.homeManagerModules.default
    inputs.hyprlock.homeManagerModules.default
  ];

  programs.hyprlock = {
    enable = true;

    general = {
      no_fade_in = true;
    };
    backgrounds = [
      {
        path = config.wallpaper;
      }
    ];

    labels = [
      {text = "";}
    ];
    input-fields = [
      {
        position = {
          x = 0;
          y = -400;
        };
      }
    ];
  };

  services.hypridle = {
    enable = true;
    lockCmd = "${pkgs.writeShellScript "lock" ''
      playerctl pause
      playerctl -p spotify pause
      ${lib.getExe config.programs.hyprlock.package}
    ''}";
  };
}
