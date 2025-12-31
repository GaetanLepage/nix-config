{
  flake.modules.homeManager.core = {
    programs.nixvim = {
      luaLoader.enable = true;

      performance = {
        combinePlugins = {
          enable = true;
          standalonePlugins = [
            "hmts.nvim"
            "neorg"
            "nvim-treesitter"

            # `.gitignore` conflicts with blink-cmp's
            "typst-preview.nvim"
          ];
        };
        byteCompileLua.enable = true;
      };
    };
  };
}
