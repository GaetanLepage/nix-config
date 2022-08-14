{ ... }:

{
    home.packages = with pkgs; [
        # Python
        (python3.withPackages(ps: with ps; [
            # Misc
            pip
            setuptools
            dbus-python             # Needed by the polybar spotify script

            # Neovim
            pynvim                  # Python support for neovim

            ## Linters
            flake8
            mypy
            pylint

            ## Python Language Server
            pyls-flake8             # Flake8 plugin for pylsp
            python-lsp-server       # Python language server
            pylsp-mypy              # mypy plugin for pylsp

            # RL
            gym
            ipython
            matplotlib
            numpy
            # pandas
            pytorch
        ]))
    ];
}
