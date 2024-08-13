{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      # Python
      (python311.withPackages (
        ps:
          with ps; [
            # Misc
            pip
            setuptools

            # RL
            matplotlib
            numpy
            torch
          ]
      ))

      mypy
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

        lint = {
          per-file-ignores = {
            # Ignore `F401` (unused import) in all `__init__.py` files
            "__init__.py" = ["F401"];
          };
        };
      };
    };

    nixvim = {
      filetype.extension.gin = "gin";
      plugins = {
        treesitter.languageRegister.python = ["gin"];
        lsp-format.lspServersToEnable = ["ruff"];
        lsp.servers = {
          ruff.enable = true;
          pylsp = {
            enable = true;
            settings = {
              plugins = {
                jedi_completion.fuzzy = true;

                pylsp_mypy.enabled = true;

                # We don't need those as ruff is already providing such features.
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
