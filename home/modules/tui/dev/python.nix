{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      ruff

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

  xdg.configFile."ruff/ruff.toml".text = ''
    line-length = 100

    [per-file-ignores]
    # Ignore `F401` (unused import) in all `__init__.py` files
    "__init__.py" = ["F401"]
  '';

  programs.nixvim = {
    plugins.lsp.servers = {
      pylsp = {
        # cmd = ["pylsp" "-vvv" "--log-file" "pylsp.log"];
        enable = true;
        settings = {
          plugins = {
            pylsp_mypy = {
              enabled = true;
              live_mode = false;
              dmypy = true;
            };
            jedi_completion.fuzzy = true;

            # Enable formatting
            black = {
              enabled = true;
              cache_config = true;
            };

            ruff = {
              enabled = true;
              lineLength = 100;
              perFileIgnores = {
                "__init__.py" = ["F401"];
              };
            };

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
    };
  };
}
