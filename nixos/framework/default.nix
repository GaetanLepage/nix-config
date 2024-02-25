{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    ../common

    ./android.nix
    ./autofs.nix
    ./bluetooth.nix
    ./disko.nix
    ./neovim.nix
    ./obs.nix
    ./packages.nix
    ./sound.nix
    ./thunar.nix
    ./wayland.nix
    ./wireguard
  ];

  networking.hostName = "framework";
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFw27a8MzCrI+oAoL+HsoYEq4YZrNv0TJYpOEb9rMZxV";

  # Sharing pulseaudio server
  networking.firewall.allowedTCPPorts = [4713];

  fonts.packages = with pkgs; [
    noto-fonts
    (nerdfonts.override {
      fonts = [
        "DejaVuSansMono"
        "UbuntuMono"
      ];
    })
  ];

  services = {
    gnome.gnome-keyring.enable = true;
    udisks2.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  programs.dconf.enable = true;

  system = {
    autoUpgrade.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "23.05"; # Did you read the comment?
  };
}
