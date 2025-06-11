{
  imports = [
    ../../modules/tui
    ../../modules/gui

    ./csgo
  ];

  wayland.windowManager.sway.extraOptions = [ "--unsupported-gpu" ];

  services.kanshi._profiles = {
    main = {
      screens.home.status = "enable";
      wifi = false;
    };
  };
}
