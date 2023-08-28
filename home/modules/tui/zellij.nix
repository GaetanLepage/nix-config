{
  home.shellAliases = {
    zj = "zellij";
  };

  programs.zellij = {
    enable = true;

    settings = {
      # Make zellij UI more compact
      pane_frames = false;
      default_layout = "compact";

      theme = "gruvbox-dark";

      themes = {
        gruvbox-dark = {
          fg = [213 196 161];
          bg = [40 40 40];
          black = [60 56 54];
          red = [204 36 29];
          green = [152 151 26];
          yellow = [215 153 33];
          blue = [69 133 136];
          magenta = [177 98 134];
          cyan = [104 157 106];
          white = [251 241 199];
          orange = [214 93 14];
        };
      };
    };
  };
}
