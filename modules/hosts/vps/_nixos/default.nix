{ lib, ... }:
{
  imports = [
    ./disko.nix
    ./hardware.nix

    ./dns.nix
    ./caddy.nix
    ./email
    ./hedgedoc.nix
    ./jitsi.nix
    ./microbin
    ./mumble.nix
    ./vaultwarden
    ./vikunja.nix
    ./wireguard
  ];

  services = {
    postgresqlBackup.enable = true;

    nginx.enable = lib.mkForce false;
  };

  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO1Oy9/d0KtPZSf1bhJjItykOJEz43uPLNpYPdJ8bd8x";

  boot.loader.systemd-boot.enable = lib.mkForce false;

  system.stateVersion = "24.05";
}
