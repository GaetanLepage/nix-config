{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      nixvimInjections = true;

      folding = true;
      indent = true;
    };

    treesitter-refactor = {
      enable = true;
      highlightDefinitions.enable = true;
    };

    hmts.enable = true;
  };
}
