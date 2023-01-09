{
    programs.nixvim = {

        options.completeopt = "menu,menuone,noselect";

        plugins.nvim-cmp = {
            enable = true;

            sources = [
                { name = "path"; }
                { name = "nvim_lsp"; }
                { name = "cmp_tabnine"; }
                { name = "luasnip"; }
                { name = "buffer"; }
                { name = "neorg"; }
            ];
        };
    };
}
