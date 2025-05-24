{ config, ... }:
{
  flake.modules.homeManager.host_cuda = {
    imports = with config.flake.modules.homeManager; [
      csConfig
    ];

    wayland.windowManager.sway.extraOptions = [ "--unsupported-gpu" ];

    services.kanshi._profiles = {
      main = {
        screens.home.status = "enable";
        wifi = false;
      };
    };
  };
}
