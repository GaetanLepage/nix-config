{
  programs.nixvim = {
    globals.mapleader = " ";

    maps = {
      # silentDefault = true;

      normal."<Space>" = "<NOP>";

      # Esc to clear search results
      normal."<esc>" = ":noh<CR>";

      # fix Y behaviour
      normal."Y" = "y$";

      # back and fourth between the two most recent files
      normal."<C-c>" = ":b#<CR>";
      normal."<leader>c" = ":b#<CR>";

      # close by Ctrl+x
      normal."<C-x>" = ":close<CR>";

      # save by Space+s or Ctrl+s
      normal."<leader>s" = ":w<CR>";
      normal."<C-s>" = ":w<CR>";

      # better window movement TODO change
      normal."<C-h>" = "<C-w>h";
      normal."<C-j>" = "<C-w>j";
      normal."<C-k>" = "<C-w>k";
      normal."<C-l>" = "<C-w>l";
      normal."<leader>h" = "<C-w>h";
      # normal."<leader>j" = "<C-w>j";
      # normal."<leader>k" = "<C-w>k";
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

      # Tab switch buffer TODO: remove ?
      # normal."<TAB>" = ":bnext<CR>";
      # normal."<S-TAB>" = ":bprevious<CR>";

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
