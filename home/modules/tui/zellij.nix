{
  home.shellAliases = {
    zj = "zellij";
    zz = "zellij attach --create main";
  };

  programs.zellij = {
    enable = true;

    # Disable auto-starting zellij
    enableFishIntegration = false;

    settings = {
      # Make zellij UI more compact
      pane_frames = false;
      default_layout = "compact";

      theme = "gruvbox-dark";

      keybinds = {
        normal = {
          unbind = [
            "Ctrl b"
            "Ctrl p"
            "Ctrl s"
          ];
          "bind \"Ctrl B\"".SwitchToMode._args = [ "tmux" ];
          "bind \"Ctrl P\"".SwitchToMode._args = [ "pane" ];
          "bind \"Ctrl S\"".SwitchToMode._args = [ "scroll" ];
        };
      };
    };
  };
}
