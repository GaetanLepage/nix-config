{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    # System
    ./backup
    ./users.nix
    ./zfs
    ./disko.nix

    # File sharing
    ./nfs.nix
    ./samba.nix

    # Web server
    ./caddy.nix

    # Database
    ./postgresql.nix

    # Services
    ./deluge
    ./invidious
    # ./jitsi.nix
    ./nextcloud
    ./pigallery2.nix
    ./wireguard
  ];

  networking = {
    hostName = "tank";

    # Needed for ZFS
    # generated using `head -c 8 /etc/machine-id`
    hostId = "f504d887";
  };

  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpwnnDFq6MrqjvwYikioz5kr3iOgD3iC+rPm6rC2O4b";

  services.nginx.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    # Network
    lsof
    wol
    dig

    yt-dlp
  ];

  system.stateVersion = "22.05";
}
