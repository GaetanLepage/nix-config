{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>n";
        action = ":Neotree action=focus reveal toggle<CR>";
        options.silent = true;
      }
    ];

    plugins.neo-tree = {
      enable = true;

      settings = {
        close_if_last_window = true;
        window = {
          width = 30;
          auto_expand_width = true;
        };
        filesystem = {
          filtered_items.hide_by_pattern = [
            "*.pdf"
          ];
        };
      };
    };
  };
}
