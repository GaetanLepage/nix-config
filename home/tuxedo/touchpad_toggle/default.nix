{pkgs, ...}: {
  home.sessionPath = let
    touchpadToggleScript =
      pkgs.writeShellScriptBin
      "touchpad_toggle"
      (builtins.readFile ./script.sh);

    touchpadToggleScriptPath = "${toString touchpadToggleScript}/bin";
  in [touchpadToggleScriptPath];
}
