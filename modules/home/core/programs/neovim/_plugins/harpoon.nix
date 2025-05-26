{ lib, ... }:
{
  programs.nixvim = {
    plugins.harpoon.enable = true;

    keymaps =
      lib.mapAttrsToList
        (key: action: {
          mode = "n";
          inherit key;
          action.__raw = action;
          options.silent = true;
        })
        {
          # add current file
          "<leader>a" = "function() require'harpoon':list():add() end";

          # open menu
          "<C-e>" = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";

          # navigation
          "<C-j>" = "function() require'harpoon':list():select(1) end";
          "<C-k>" = "function() require'harpoon':list():select(2) end";
          "<C-l>" = "function() require'harpoon':list():select(3) end";
          "<C-m>" = "function() require'harpoon':list():select(4) end";
        };
  };
}
