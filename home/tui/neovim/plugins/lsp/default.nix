{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

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
          bashls.enable = true;
          clangd.enable = true;
          nil_ls.enable = true;
          lua-ls.enable = true;
          pylsp = {
            cmd = ["pylsp"];
            # cmd = [ "pylsp" "-vvv" "--log-file" "pylsp.log"];
            enable = true;
            settings = {
              plugins = {
                pylsp_mypy = {
                  enabled = true;
                  live_mode = false;
                  dmypy = true;
                };
                jedi_completion.fuzzy = true;

                # We don't need those as ruff-lsp is already providing such features.
                autopep8.enabled = false;
                flake8.enabled = false;
                mccabe.enabled = false;
                preload.enabled = false;
                pycodestyle.enabled = false;
                pydocstyle.enabled = false;
                pyflakes.enabled = false;
                pylint.enabled = false;
                yapf.enabled = false;
              };
            };
          };
          ruff-lsp = {
            enable = true;
            extraOptions.init_options.settings.args = [
              "--config=${./ruff.toml}"
            ];
          };
          texlab.enable = true;
          typst-lsp.enable = true;
          rust-analyzer.enable = true;
        };
      };
    };
  };
}
