{
  programs.nixvim = {
    luaLoader.enable = true;

    performance = {
      combinePlugins = {
        enable = true;
        standalonePlugins = [
          "hmts.nvim"
          "neorg"
          "nvim-treesitter"

          # `queries/lua/highlights.scm` conflicts with nvim-treesitter-grammars
          "snacks.nvim"

          # `.gitignore` conflicts with blink-cmp
          "typst-preview.nvim"
        ];
      };
      byteCompileLua.enable = true;
    };
  };
}
