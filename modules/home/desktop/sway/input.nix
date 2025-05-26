{
  flake.modules.homeManager.sway = {
    wayland.windowManager.sway.config.input = {
      "type:keyboard" = {
        xkb_layout = "fr";
        xkb_options = "caps:swapescape";
        xkb_numlock = "enabled";

        repeat_delay = "300";
        repeat_rate = "50";
      };

      "type:touchpad" = {
        tap = "enabled";
      };
    };
  };
}
