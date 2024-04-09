{config, ...}: {
  age.secrets = {
    builder-ssh-key.rekeyFile = ./ssh-key.age;
  };

  nix.buildMachines = [
    {
      hostName = "auriga";
      sshUser = "root";
      sshKey = config.age.secrets.builder-ssh-key.path;
      publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUU3Vi9GRW9EQmxwQWg3NzM3VjJRcTYzbXA2Nk85WVhMRWRBREIzRVZEMmggcm9vdEBwb3Atb3MK";
      systems = ["x86_64-linux"];
      maxJobs = 48;
      speedFactor = 8;
      supportedFeatures = [
        "big-parallel"
      ];
    }
  ];
}
