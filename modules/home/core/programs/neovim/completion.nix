{
  flake.modules.homeManager.core =
    { pkgs, lib, ... }:
    {
      programs.nixvim = {
        opts.completeopt = [
          "menu"
          "menuone"
          "noselect"
        ];

        extraPlugins = [
          (pkgs.vimUtils.buildVimPlugin {
            pname = "blink-cmp-nixpkgs-maintainers";
            version = "1";
            src = pkgs.fetchFromGitHub {
              owner = "GaetanLepage";
              repo = "blink-cmp-nixpkgs-maintainers";
              rev = "b572f807ca3b4b6f87c791b0d5ceaa81dbb00d70";
              hash = "sha256-ollZI9Bd3eAKvzS84oIzToVruYbCERKKhZpIR+cBxBE=";
            };
            dependencies = [
              pkgs.vimPlugins.blink-cmp
            ];
          })
        ];

        plugins = {
          luasnip.enable = true;

          cmp-nixpkgs-maintainers.enable = lib.mkForce false;

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
                ];
                providers = {
                  # Words from other open buffers can also be suggested.
                  buffer.opts.get_bufnrs.__raw = "vim.api.nvim_list_bufs";

                  nixpkgs_maintainers = {
                    name = "nixpkgs maintainers";
                    module = "blink_cmp_nixpkgs_maintainers";
                  };
                };
                per_filetype = {
                  markdown = [
                    {
                      __unkeyed = "nixpkgs_maintainers";
                      inherit_defaults = true;
                    }
                  ];
                };
              };
            };
          };
        };
      };
    };
}
