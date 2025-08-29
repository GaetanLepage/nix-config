{
  flake.modules.nixos.host_framework =
    { pkgs, ... }:
    {
      networking.hostName = "framework";

      # inria (needed for the VPN)
      networking.networkmanager.plugins = [ pkgs.networkmanager-openconnect ];

      age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM+Md7yZTk3GWd0XVRQkplboDPLGkSqE/o6/SsfrrGGS";

      services = {
        # Default is "poweroff" which shutdowns the laptop as soon as the power button is pressed.
        logind.settings.Login.HandlePowerKey = "lock";
      };

      programs = {
        # light (backlight control)
        light.enable = true;

        # Some programs need SUID wrappers, can be configured further or are started in user sessions.
        dconf.enable = true;
      };

      boot.loader.timeout = 0;

      my-modules = {
        remoteBuilders.linuxMaxJobs = 0;
      };

      system = {
        autoUpgrade.enable = false;

        stateVersion = "24.05";
      };
    };
}
