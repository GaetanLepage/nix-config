{
  programs.nixvim = {
    plugins.tagbar = {
      enable = true;
      extraConfig.width = 50;
    };

    maps.normal."<C-g>" = {
      action = ":TagbarToggle<cr>";
      silent = true;
    };
  };
}
