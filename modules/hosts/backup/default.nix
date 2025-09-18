{ config, ... }:
{
  nixosHosts.backup = {
    unstable = false;
  };

  flake.modules.nixos.host_backup = {
    networking.hostName = "backup";

    age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDBSFYOqETOI1WDbKieqGIz5iHzys9n92eo/KBhPHeJh";

    system.stateVersion = "22.05";

    imports = with config.flake.modules.nixos; [
      server
    ];
  };
}
