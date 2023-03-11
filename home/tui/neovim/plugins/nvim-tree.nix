{
  programs.nixvim = {
    maps.normal."<leader>n" = {
      action = ":NvimTreeToggle<CR>";
      silent = true;
    };

    plugins.nvim-tree = {
      enable = true;

      autoClose = true;

      # Hijack the cursor in the tree to put it at the start of the filename.
      hijackCursor = true;

      diagnostics = {
        enable = true;

        icons = {
          hint = "";
          info = "";
          warning = "";
          error = "";
        };
      };
      git.enable = false;

      updateFocusedFile.enable = true;

      # `false` by default, this option shows indent markers when folders are open
      renderer.indentMarkers.enable = true;

      filters = {
        dotfiles = true;
        custom = [
          "\.git"
          "node_modules"
          ".cache"
          "__pycache__"
          "*.aux"
          "*.bbl"
          "*.blg"
          "*.egg-info"
          "*.fdb_latexmk"
          "*.fls"
          "*.maf"
          "*.mtc"
          "*.mtc0"
          "*.pyc"
          "*.run.xml"
          "*.synctex*"
        ];
      };
    };
  };
}
