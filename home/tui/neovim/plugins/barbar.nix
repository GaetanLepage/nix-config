{
  programs.nixvim = {
    plugins.barbar.enable = true;

    maps.normal = {
      "<TAB>" = ":BufferNext<CR>";
      "<S-TAB>" = ":BufferPrevious<CR>";

      "<C-w>" = ":BufferClose<CR>";
    };
  };
}
