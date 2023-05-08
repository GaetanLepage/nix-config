{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    ../common

    ./android.nix
    ./autofs.nix
    ./bluetooth.nix
    ./davfs.nix
    ./neovim.nix
    ./packages.nix
    ./sound.nix
    ./ssh.nix
    ./thunar.nix
    # ./virtualbox.nix
    # ./wacom.nix
    ./wayland.nix
    ./wireguard.nix
    # ./xorg.nix
  ];

  networking.hostName = "tuxedo";
  # Sharing pulseaudio server
  networking.firewall.allowedTCPPorts = [4713];

  fonts.fonts = with pkgs; [
    noto-fonts
    (nerdfonts.override {
      fonts = [
        "DejaVuSansMono"
        "UbuntuMono"
      ];
    })
  ];

  services.gnome.gnome-keyring.enable = true;

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
    stateVersion = "22.11"; # Did you read the comment?
  };
}
