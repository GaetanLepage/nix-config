{pkgs, ...}: {
  # programs.wofi = {
  #   enable = true;
  #
  #   style = ''
  #     * {
  #         font-family: DejaVu Sans Mono;
  #         font-size: 16;
  #     }
  #   '';
  # };
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    font = "DejaVu Sans Mono 16";
    theme = "gruvbox-dark";
  };
}
