{
  home.shellAliases.h = "herdr";
  programs.herdr = {
    enable = true;

    settings = {
      onboarding = false;

      theme.name = "gruvbox";

      ui = {
        status_indicators = "dots";

        toast.delivery = "herdr";
        sound.enabled = true;
        prompt_new_tab_name = false;

        tab_bar_position = "bottom";
      };

      keys = {
        prefix = "ctrl+space";
        detach = [ "prefix+d" ];

        # Tabs
        next_tab = [ "alt+l" ];
        previous_tab = [ "alt+h" ];
        rename_tab = [ "prefix+r" ];
        new_tab = [ "prefix+n" ];
        close_tab = [ "prefix+x" ];
        move_tab_previous = [ "alt+i" ];
        move_tab_next = [ "alt+o" ];

        # Splits
        split_vertical = [ "alt+n" ];

        # Workspaces
        new_workspace = [ "ctrl+N" ];
        rename_workspace = [ "ctrl+R" ];
        previous_workspace = [ "alt+k" ];
        next_workspace = [ "alt+j" ];

        # Agents
        previous_agent = [ "alt+K" ];
        next_agent = [ "alt+J" ];
      };
    };
  };
}
