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
      };

      keys = {
        prefix = "ctrl+space";
        detach = [ "prefix+d" ];

        # Tabs
        next_tab = [ "alt+l" ];
        previous_tab = [ "alt+h" ];
        rename_tab = [ "prefix+r" ];
        new_tab = [ "alt+n" ];
        close_tab = [ "prefix+x" ];
        move_tab_previous = [ "alt+i" ];
        move_tab_next = [ "alt+o" ];

        # Workspaces
        new_workspace = [ "ctrl+N" ];
        rename_workspace = [ "ctrl+R" ];
        previous_workspace = [ "alt+k" ];
        next_workspace = [ "alt+j" ];

        # Agents
        previous_agent = [ "ctrl+k" ];
        next_agent = [ "ctrl+j" ];
      };
    };
  };
}
