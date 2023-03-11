{lib, ...}: {
  programs.nixvim = {
    maps.normal =
      lib.mapAttrs (key: luaFunc: {
        silent = true;
        action = luaFunc;
        lua = true;
      })
      {
        "gd" = "vim.lsp.buf.definition";
        "gD" = "vim.lsp.buf.references";
        "gt" = "vim.lsp.buf.type_definition";
        "gi" = "vim.lsp.buf.implementation";
        "K" = "vim.lsp.buf.hover";

        # Navigate in diagnostics
        "<leader>k" = "vim.diagnostic.goto_prev";
        "<leader>j" = "vim.diagnostic.goto_next";

        # Rename
        "<F2>" = "vim.lsp.buf.rename";
      };

    plugins = {
      lsp = {
        enable = true;

        servers = {
          bashls.enable = true;
          clangd.enable = true;
          nil_ls.enable = true;
          lua-ls.enable = true;
          pylsp = import ./pylsp-settings.nix;
          texlab.enable = true;
          rust-analyzer.enable = true;
        };
      };
    };
  };
}
