{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      # Python
      (python3.withPackages (ps:
        with ps; [
          # Misc
          pip
          setuptools
          dbus-python # Needed by the polybar spotify script

          # RL
          gymnasium
          matplotlib
          numpy
          torch-bin
          tensorboard
        ]))
    ];

    shellAliases."pyp" = "PYTHONPATH=. python";
  };
}
