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
        screens = {
          lg_27.status = "enable";
          benq.status = "disable";
        };
        wifi = false;
      };
      stream = {
        screens = {
          lg_27 = {
            status = "enable";
            position = "0,247";
          };
          benq = {
            status = "enable";
            position = "2560,0";
            transform = "90";
          };
        };
        wifi = false;
      };
    };
  };
}
