{
  programs.ghostty = {
    enable = true;
    package = null;

    settings = {
      macos-option-as-alt = false;

      # Font settings
      font-size = 18;
      font-family = "DejaVu Sans Mono";
      # Disable ligatures
      font-feature = "-calt, -liga, -dlig";

      window-inherit-working-directory = false;

      background = "000000";

      keybind = [
        "super+n=new_tab"

        "super+h=previous_tab"
        "super+l=next_tab"

        "super+shift+l=move_tab:+1"
        "super+shift+h=move_tab:-1"
      ];
    };
  };
}
