{
  flake.modules.homeManager.core =
    { lib, config, ... }:
    {
      services.ssh-agent.enable = true;

      programs.ssh = {
        enable = true;

        # Explicitly declare default config and disable HM's vendored one.
        # This will be deprecated after some time.
        enableDefaultConfig = false;

        matchBlocks = {
          # Sane settings
          "*" = {
            forwardAgent = false;
            addKeysToAgent = "no";
            compression = false;
            serverAliveInterval = 0;
            serverAliveCountMax = 3;
            hashKnownHosts = false;
            userKnownHostsFile = "~/.ssh/known_hosts";
            controlMaster = "no";
            controlPath = "~/.ssh/master-%r@%n:%p";
            controlPersist = "no";
          };
        };
      };
    };
}
