{
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings.exec-once = [
    (
      lib.getExe
      (pkgs.writeShellApplication {
        name = "dynamic-borders";
        text = builtins.readFile ./script.sh;
        runtimeInputs = with pkgs; [
          jq
          socat
        ];
        checkPhase = "";
      })
    )
  ];
}
