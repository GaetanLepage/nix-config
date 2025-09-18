{ config, ... }:
{
  nixosHosts.backup = {
    unstable = false;

    modules = [
      {
        networking.hostName = "backup";

        age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDBSFYOqETOI1WDbKieqGIz5iHzys9n92eo/KBhPHeJh";

        system.stateVersion = "22.05";
      }
      config.flake.modules.nixos.server

      ./_hardware.nix
      ./_wireguard
      ./_zfs.nix
    ];
  };
}
