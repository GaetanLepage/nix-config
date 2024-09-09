{
  programs.nixvim = {
    plugins.markdown-preview = {
      enable = true;

      settings = {
        auto_close = 0;
        theme = "dark";
      };
    };

    files."after/ftplugin/markdown.lua".keymaps = [
      {
        mode = "n";
        key = "<leader>m";
        action = ":MarkdownPreview<cr>";
      }
    ];
  };
}
