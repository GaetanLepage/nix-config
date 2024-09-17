{
  # inria
  programs.nixvim = {
    plugins.vimtex = {
      enable = true;

      settings = {
        view_method = "zathura";

        quickfix_enabled = true;
        quickfix_open_on_warning = false;

        # Ignore undesired errors and warnings
        quickfix_ignore_filters = [
          "Underfull"
          "Overfull"
          "specifier changed to"
          "Token not allowed in a PDF string"
        ];

        # TOC settings
        toc_config = {
          name = "TOC";
          layers = ["content" "todo"];
          resize = true;
          split_width = 50;
          todo_sorted = false;
          show_help = true;
          show_numbers = true;
          mode = 2;
        };
      };
    };

    files."after/ftplugin/tex.lua".keymaps = [
      {
        mode = "n";
        key = "m";
        action = ":VimtexView<cr>";
      }
    ];

    autoCmd = [
      {
        event = ["BufEnter" "BufWinEnter"];
        pattern = "*.tex";
        command = "set filetype=tex \"| VimtexTocOpen";
      }

      # Folding
      {
        event = "FileType";
        pattern = ["tex" "latex"];
        callback.__raw = ''
          function ()
            vim.o.foldmethod = 'expr'
            vim.o.foldexpr = 'vimtex#fold#level(v:lnum)'
            vim.o.foldtext = 'vimtex#fold#text()'
          end
        '';
      }

      # Compile on initialization
      {
        event = "User";
        pattern = "VimtexEventInitPost";
        callback = "vimtex#compiler#compile";
      }

      # Cleanup on exit
      {
        event = "User";
        pattern = "VimtexEventQuit";
        command = "call vimtex#compiler#clean(0)";
      }
    ];
  };
}
