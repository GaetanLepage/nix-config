{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      # Python
      # inria
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

    sessionVariables.MYPY_CACHE_DIR = "${config.xdg.cacheHome}/mypy";
  };

  programs = {
    ruff = {
      enable = true;

      settings = {
        line-length = 100;
      };
    };

    nixvim = {
      filetype.extension.gin = "gin"; # inria
      plugins = {
        treesitter.languageRegister.python = ["gin"]; # inria
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
