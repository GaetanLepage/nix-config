{
  programs.nixvim = {
    diagnostic.settings.virtual_text = true;

    plugins = {
      lsp-format = {
        enable = true;
        lspServersToEnable = "all";
      };

      lsp = {
        enable = true;

        inlayHints = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };

        servers = {
          clangd.enable = true;
          texlab.enable = true; # inria
          lua_ls = {
            enable = true;
            settings.diagnostics.globals = [ "vim" ];
          };
        };
      };
    };
  };
}
