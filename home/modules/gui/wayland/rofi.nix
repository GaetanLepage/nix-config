{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    font = "DejaVu Sans Mono 16";
    theme = "gruvbox-dark";
  };
}
