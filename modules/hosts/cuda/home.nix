{ config, ... }:
{
  flake.modules.homeManager.host_cuda = {
    imports = with config.flake.modules.homeManager; [
      csConfig
      desktop
    ];

    wayland.windowManager.sway.extraOptions = [ "--unsupported-gpu" ];

    services.kanshi._profiles = {
      main = {
        screens.lg_27.status = "enable";
        wifi = false;
      };
    };
  };
}
