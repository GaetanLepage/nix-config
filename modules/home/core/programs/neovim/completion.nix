{
  flake.modules.homeManager.core = {
    programs.nixvim = {
      opts.completeopt = [
        "menu"
        "menuone"
        "noselect"
      ];

      plugins = {
        luasnip.enable = true;

        blink-cmp = {
          enable = true;

          settings = {
            cmdline.enabled = false;

            snippets.preset = "luasnip";

            completion = {
              list.selection.preselect = false;
              documentation = {
                auto_show = true;
                auto_show_delay_ms = 0;
              };
            };

            keymap = {
              "<Tab>" = [
                "select_next"
                "fallback"
              ];
              "<S-Tab>" = [
                "select_prev"
                "fallback"
              ];
              "<CR>" = [
                "select_and_accept"
                "fallback"
              ];
            };

            sources = {
              default = [
                "lsp"
                "path"
                "snippets"
                "buffer"
                # "nixpkgs_maintainers" TODO
              ];
              providers = {
                # Words from other open buffers can also be suggested.
                buffer.opts.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              };
            };
          };
        };
      };
    };
  };
}
