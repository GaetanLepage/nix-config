{
  programs.nixvim.plugins.barbar = {
    enable = true;
    keymaps = {
      next.key = "<TAB>";
      previous.key = "<S-TAB>";
      close = {
        key = "<C-w>";
        # No delay after pressing C-w
        options.nowait = true;
      };
    };
  };
}
