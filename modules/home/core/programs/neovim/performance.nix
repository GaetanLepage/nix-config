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
          ];
        };
        byteCompileLua.enable = true;
      };
    };
  };
}
