{pkgs, ...}: {
  home.packages = [
    (
      pkgs.writeShellScriptBin "pyenv" ''
        /usr/bin/python3.11 -m venv venv
        source /venv/bin/activate

        pip install -U pip
        pip install -e .
        pip install pytest
        pip install -e ".[test]"
      ''
    )
  ];
}
