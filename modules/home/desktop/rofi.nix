{
  flake.modules.homeManager.rofi = {
    programs.rofi = {
      enable = true;

      theme = "gruvbox-dark";
      settings = {
        font = "DejaVu Sans Mono 18";
      };
    };
  };
}
