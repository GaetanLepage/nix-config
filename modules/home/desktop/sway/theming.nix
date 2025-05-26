{
  flake.modules.homeManager.sway = {
    wayland.windowManager.sway = {
      config = {
        window = {
          hideEdgeBorders = "smart";
          titlebar = false;
        };

        fonts = {
          names = [ "DejaVu Sans Mono" ];
          size = 12.0;
        };

        colors =
          let
            background = "#282828";
            red = "#cc241d";
            purple = "#b16286";
            darkgray = "#1d2021";
            lightgray = "#ebdbb2";
          in
          {
            focused = {
              border = lightgray;
              background = lightgray;
              text = background;
              indicator = purple;
              childBorder = lightgray;
            };
            focusedInactive = {
              border = darkgray;
              background = darkgray;
              text = lightgray;
              indicator = purple;
              childBorder = darkgray;
            };
            unfocused = {
              border = darkgray;
              background = darkgray;
              text = lightgray;
              indicator = purple;
              childBorder = darkgray;
            };
            urgent = {
              border = red;
              background = red;
              text = lightgray;
              indicator = red;
              childBorder = red;
            };
          };
      };
    };
  };
}
