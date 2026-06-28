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

  # permittedInsecurePackages is not correctly merged, so it needs to be defined at a unique place
  nixpkgs.config.permittedInsecurePackages = [
    # Jitsi
    "jitsi-meet-1.0.8792"

    # Vikunja
    # 2026-06-28: pnpm is marked as insecure
    # https://github.com/NixOS/nixpkgs/issues/535579
    "pnpm-10.29.2"
  ];

  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKdmJihZSPw7rbpaNG8Pixa3kCWTXzO9ZYnhmqvSn8/d";

  boot.loader.systemd-boot.enable = lib.mkForce false;

  system.stateVersion = "24.05";
}
