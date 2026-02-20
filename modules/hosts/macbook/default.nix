{ config, ... }:
{
  darwinHosts.macbook = {
    unstable = true;

    modules = [
      config.flake.modules.darwin.agenix
      # config.flake.modules.darwin.home-manager
      config.flake.modules.darwin.dev
      ./_darwin

      {
        age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILMcS55T9dqFsD+wQJZolmf+TvpPCsdD4n7+7mkSM0dy";

        system.stateVersion = 6;
      }
    ];

    homeManagerModules = [
      ./_home
    ];
  };
}
