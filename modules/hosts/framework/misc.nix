{
  flake.modules.nixos.host_framework =
    { pkgs, ... }:
    {
      age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM+Md7yZTk3GWd0XVRQkplboDPLGkSqE/o6/SsfrrGGS";

      programs = {
        # light (backlight control)
        light.enable = true;

        # Some programs need SUID wrappers, can be configured further or are started in user sessions.
        dconf.enable = true;
      };

      boot.loader.timeout = 0;

      system = {
        autoUpgrade.enable = false;

        stateVersion = "24.05";
      };
    };
}
