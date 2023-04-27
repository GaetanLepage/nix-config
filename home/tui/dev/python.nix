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
      "pyp" = "PYTHONPATH=. python";
      "ruff" = "${pkgs.ruff}/bin/ruff --config=${../neovim/plugins/lsp/ruff.toml}";
    };
  };
}
