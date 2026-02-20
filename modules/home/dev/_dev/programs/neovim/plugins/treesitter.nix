{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      nixvimInjections = true;

      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
      folding.enable = true;
    };

    treesitter-refactor = {
      # TODO: incompatible with treesitter-nvim's main branch
      # Consider switching to nvim-treesitter-locals
      # https://github.com/NixOS/nixpkgs/pull/476829
      enable = false;

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
