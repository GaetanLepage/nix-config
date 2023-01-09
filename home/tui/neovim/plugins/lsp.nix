{
    programs.nixvim = {

        maps.normal = {
            "gd" = "vim.lsp.buf.definition";
            "gD" = "vim.lsp.buf.references";
            "gt" = "vim.lsp.buf.type_definition";
            "gi" = "vim.lsp.buf.implementation";
            "K"  = "vim.lsp.buf.hover";

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
                    rnix-lsp.enable = true;
                    sumneko-lua.enable = true;
                    texlab.enable = true;
                    rust-analyzer.enable = true;
                };
            };
        };
    };
}
