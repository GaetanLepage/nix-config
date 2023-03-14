{
  programs.nixvim = {
    maps.normal."<leader>n" = {
      action = ":NeoTreeFocusToggle<CR>";
      silent = true;
    };

    plugins.neo-tree = {
      enable = true;

      closeIfLastWindow = true;
      window = {
        width = 30;
        autoExpandWidth = true;
      };
    };
  };
}
