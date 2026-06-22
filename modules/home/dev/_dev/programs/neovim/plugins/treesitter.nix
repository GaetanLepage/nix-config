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

    # Incompatible with neovim>=0.12.0
    # https://github.com/calops/hmts.nvim/issues/39
    hmts.enable = false;
  };
}
