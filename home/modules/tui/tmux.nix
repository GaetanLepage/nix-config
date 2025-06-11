{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    # Rather than constraining window size to the maximum size of any client
    # connected to the *session*, constrain window size to the maximum size of any
    # client connected to *that window*. Much more reasonable.
    aggressiveResize = true;

    clock24 = true;

    # Allows for faster key repetition
    escapeTime = 50;

    keyMode = "vi";
    # Overrides the hjkl and HJKL bindings for pane navigation and resizing in VI mode
    customPaneNavigationAndResize = true;

    shortcut = "a";

    plugins = with pkgs.tmuxPlugins; [
      gruvbox
    ];

    extraConfig = ''
      # Enable mouse
      set -g mouse on

      # 2x C-a goes back and fourth between most recent windows
      bind-key C-a last-window

      # For neovim
      set -g focus-events on

      # Update the status line every seconds
      set -g status-interval 1

      # auto window rename
      set -g automatic-rename
      set -g automatic-rename-format '#{pane_current_command}'
    '';
  };

  home.shellAliases = {
    tm = "tmux";
    tms = "tmux new -s";
    tml = "tmux list-sessions";
    tma = "tmux attach -t";
    tmk = "tmux kill-session -t";
  };
}
