{ lib, ... }:
{
  # Unset NIXOS_OZONE_WL fixes flickering Discord on sway+Nvidia
  # https://discourse.nixos.org/t/nvidia-sway-flickering/65262/18
  home.sessionVariables.NIXOS_OZONE_WL = lib.mkForce 0;
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
}
