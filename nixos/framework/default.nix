{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    ./android.nix
    ./autofs.nix
    ./bluetooth.nix
    ./disko.nix
    ./neovim.nix
    ./sound.nix
    ./wireguard
  ];

  networking.hostName = "framework";
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM+Md7yZTk3GWd0XVRQkplboDPLGkSqE/o6/SsfrrGGS";

  # Sharing pulseaudio server
  networking.firewall.allowedTCPPorts = [ 4713 ];

  services = {
    # Disable fingerprint sensor
    fprintd.enable = false;

    # Default is "poweroff" which shutdowns the laptop as soon as the power button is pressed.
    logind.powerKey = "lock";
  };

  programs = {
    # light (backlight control)
    light.enable = true;

    # Some programs need SUID wrappers, can be configured further or are started in user sessions.
    dconf.enable = true;
  };

  boot.loader.timeout = 0;

  my-modules = {
    remoteBuilders = {
      enable = true;
      linuxMaxJobs = 0;
    };
    desktop.enable = true;
    sshClient.enable = true;
    dev.enable = true;
  };

  system = {
    autoUpgrade.enable = false;

    stateVersion = "24.05";
  };
}
