{
  imports = [
    ../../modules/tui
    ../../modules/gui

    ./csgo
  ];

  wayland.windowManager.sway.extraOptions = [ "--unsupported-gpu" ];
}
