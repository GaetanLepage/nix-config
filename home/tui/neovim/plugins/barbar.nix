{
  programs.nixvim = {
    plugins.barbar.enable = true;

    # TODO upstream bindings
    maps.normal = {
      "<TAB>" = ":BufferNext<CR>";
      "<S-TAB>" = ":BufferPrevious<CR>";

      "<C-w>" = ":BufferClose<CR>";
    };
  };
}
