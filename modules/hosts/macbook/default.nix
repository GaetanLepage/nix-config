{ config, ... }:
{
  darwinHosts.macbook = {
    unstable = true;
    # primaryUser = "gaetan";  TODO: remove if not necessary (i.e. if it is gaetan)
    modules = [
      config.flake.modules.darwin.agenix
      config.flake.modules.darwin.home-manager
      {
        system.primaryUser = "gaetan"; # TODO
        networking.hostName = "macbook"; # TODO
        users.users.gaetan.home = "/Users/gaetan";

        # age.rekey.hostPubkey = ""; # TODO

        system.stateVersion = 6;
      }
    ];
  };
}
