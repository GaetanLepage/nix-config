{
  flake.modules.homeManager.rofi =
    { pkgs, ... }:
    {
      programs.rofi = {
        enable = true;

        font = "DejaVu Sans Mono 18";
        theme = "gruvbox-dark";
      };
    };
}
