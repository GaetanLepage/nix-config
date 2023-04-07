{
  programs.nixvim = {
    maps.normal."<leader>n" = {
      action = ":Neotree action=focus reveal toggle<CR>";
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
