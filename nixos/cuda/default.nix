{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    ../common

    ./desktop
    ./disko.nix
    ./nix-remote-builder.nix
    ./server-tank-nfs.nix
    ./wireguard
  ];

  networking.hostName = "cuda";
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAtUnNTeHgiIakeJF+DrDtLyZFH1TYztokuW/BjAmRQf";

  environment.systemPackages = with pkgs; [
    # Utils
    git
    ncdu
    tmux
    unzip
    vim

    # System monitor
    btop
    htop
  ];

  my-modules = {
    nvidia.enable = true;
    remote-builders.enableX86 = true;
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
    stateVersion = "24.05"; # Did you read the comment?
  };
}
