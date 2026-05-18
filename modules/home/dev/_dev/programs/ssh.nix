{
  programs.ssh = {
    enable = true;

    # Explicitly declare default config and disable HM's vendored one.
    # This will be deprecated after some time.
    enableDefaultConfig = false;

    settings = {
      # Sane settings
      "*" = {
        ForwardAgent = false;
        AddKeysToAgent = "no";
        Compression = false;
        ServerAliveInterval = 0;
        ServerAliveCountMax = 3;
        HashKnownHosts = false;
        UserKnownHostsFile = "~/.ssh/known_hosts";
        ControlMaster = "no";
        ControlPath = "~/.ssh/master-%r@%n:%p";
        ControlPersist = "no";
      };
    };
  };
}
