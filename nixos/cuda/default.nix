{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    ../common

    ./disko.nix
    ./nix-remote-builder.nix
    ./steam.nix
    ./nvidia.nix
    ./server-tank-nfs.nix
    ./tabby.nix
    ./wireguard
    ./xorg.nix
  ];

  networking.hostName = "cuda";
  # age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDJ25NYUTHtnNZY9WCamv8ZGc00zG4EqJhyejo3TmqOu";

  environment.systemPackages = with pkgs; [
    # Utils
    git
    ncdu
    tmux
    unzip

    # System monitor
    btop
    htop
    nvtop

    # Gnome extensions
    gnomeExtensions.dash-to-panel
    gnomeExtensions.vitals

    # GUI
    discord
    firefox
    mpv
    mumble
    signal-desktop
    spotify
    teamspeak_client
    thunderbird
  ];

  programs = {
    neovim = {
      enable = true;

      defaultEditor = true;

      viAlias = true;
      vimAlias = true;
    };

    singularity.enable = true;
  };

  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
      autoSuspend = false;
    };

    desktopManager.gnome.enable = true;
  };

  system = {
    autoUpgrade = {
      enable = false; # TODO Doesn't work: use a SSH private key with agenix
      flake = "${config.users.users.gaetan.home}/config#cuda";
      flags = [
        "--update-input"
        "nixpkgs"
        "--commit-lock-file"
      ];
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "23.11"; # Did you read the comment?
  };
}
