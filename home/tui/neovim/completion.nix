{
  programs.nixvim = {
    options.completeopt = ["menu" "menuone" "noselect"];

    plugins.nvim-cmp = {
      enable = true;

      mapping = {
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.close()";
        "<Tab>" = {
          modes = ["i" "s"];
          action = "cmp.mapping.select_next_item()";
        };
        "<S-Tab>" = {
          modes = ["i" "s"];
          action = "cmp.mapping.select_prev_item()";
        };
        "<CR>" = "cmp.mapping.confirm({ select = true })";
      };

      sources = [
        {name = "path";}
        {name = "nvim_lsp";}
        {name = "cmp_tabnine";}
        {name = "luasnip";}
        {name = "buffer";}
        {name = "neorg";}
      ];
    };
  };
}
