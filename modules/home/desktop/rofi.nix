{
  flake.modules.homeManager.rofi =
    { pkgs, ... }:
    {
      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;

        font = "DejaVu Sans Mono 18";
        theme = "gruvbox-dark";
      };
    };
}
