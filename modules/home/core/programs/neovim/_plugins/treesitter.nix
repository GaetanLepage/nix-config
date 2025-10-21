{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      nixvimInjections = true;

      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
      folding = true;
    };

    treesitter-refactor = {
      enable = true;

      settings = {
        highlight_definitions = {
          enable = true;

          # Set to false if you have an `updatetime` of ~100.
          clear_on_cursor_move = false;
        };
      };
    };

    hmts.enable = true;
  };
}
