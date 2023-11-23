{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      # Python
      (python3.withPackages (ps:
        with ps; [
          # Misc
          pip
          setuptools

          # RL
          gymnasium
          matplotlib
          numpy
          torch-bin
          tensorboard
        ]))
    ];

    shellAliases = {
      pyp = "PYTHONPATH=. python";
    };
  };

  programs = {
    ruff = {
      enable = true;

      settings = {
        line-length = 100;
        per-file-ignores = {
          # Ignore `F401` (unused import) in all `__init__.py` files
          "__init__.py" = ["F401"];
        };
      };
    };

    nixvim = {
      filetype.extension.gin = "gin";
      plugins = {
        treesitter.languageRegister.python = ["gin"];
        efmls-configs.setup.python.formatter = "ruff";
        lsp.servers = {
          efm.filetypes = ["python"];
          ruff-lsp.enable = true;
          pylsp = {
            # cmd = ["pylsp" "-vvv"];
            # cmd = ["pylsp" "-vvv" "--log-file" "pylsp.log"];
            enable = true;
            settings = {
              plugins = {
                jedi_completion.fuzzy = true;

                pylsp_mypy.enabled = true;

                # We don't need those as ruff-lsp is already providing such features.
                autopep8.enabled = false;
                flake8.enabled = false;
                mccabe.enabled = false;
                preload.enabled = false;
                pycodestyle.enabled = false;
                pydocstyle.enabled = false;
                pyflakes.enabled = false;
                pylint.enabled = false;
                ruff.enabled = false;
                yapf.enabled = false;
              };
            };
          };
        };
      };
    };
  };
}
