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
}
