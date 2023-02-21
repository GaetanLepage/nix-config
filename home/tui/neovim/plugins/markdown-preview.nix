{
  programs.nixvim = {
    plugins.markdown-preview = {
      enable = true;

      autoStart = true;
      autoClose = false;

      theme = "dark";
    };

    maps.normal."<leader>m" = {
      action = ":MarkdownPreview<cr>";
      silent = true;
    };
  };
}
