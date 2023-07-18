{config, ...}: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    maps = config.nixvim.helpers.mkMaps {silent = true;} {
      normal."<Space>" = "<NOP>";

      # Esc to clear search results
      normal."<esc>" = ":noh<CR>";

      # fix Y behaviour
      normal."Y" = "y$";

      # back and fourth between the two most recent files
      normal."<C-c>" = ":b#<CR>";

      # close by Ctrl+x
      normal."<C-x>" = ":close<CR>";

      # save by Space+s or Ctrl+s
      normal."<leader>s" = ":w<CR>";
      normal."<C-s>" = ":w<CR>";

      # navigate to left/right window
      normal."<leader>h" = "<C-w>h";
      normal."<leader>l" = "<C-w>l";

      # resize with arrows
      normal."<C-Up>" = ":resize -2<CR>";
      normal."<C-Down>" = ":resize +2<CR>";
      normal."<C-Left>" = ":vertical resize +2<CR>";
      normal."<C-Right>" = ":vertical resize -2<CR>";

      # better indenting
      visual.">" = ">gv";
      visual."<" = "<gv";
      visual."<TAB>" = ">gv";
      visual."<S-TAB>" = "<gv";

      # move selected line / block of text in visual mode
      visual."K" = ":m '<-2<CR>gv=gv";
      visual."J" = ":m '>+1<CR>gv=gv";

      # move current line up/down
      # M = Alt key
      normal."<M-k>" = ":move-2<CR>";
      normal."<M-j>" = ":move+<CR>";

      normal."<leader>rp" = ":!remi push<CR>";
    };
  };
}
