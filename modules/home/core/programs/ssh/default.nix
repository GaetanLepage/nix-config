{
  flake.modules.homeManager.core =
    { lib, config, ... }:
    {
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

          "github.com" = {
            identityFile = [ config.age.secrets.ssh-github.path ];
          };
        };
      };

      # ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA3pKoSya7AukHN9XjglUutnbEvZ1sx1RHOV8CaKy+vi
      age.secrets.ssh-github.rekeyFile = ./ssh-github.age;
    };
}
