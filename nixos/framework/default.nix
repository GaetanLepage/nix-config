{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    ../_modules

    ./android.nix
    ./autofs.nix
    ./bluetooth.nix
    ./disko.nix
    ./neovim.nix
    ./packages.nix
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

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "24.05"; # Did you read the comment?
  };
}
