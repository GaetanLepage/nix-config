{ config, ... }:
{
  age.secrets = {
    builder-ssh-key.rekeyFile = ./ssh-key.age;
  };

  nix.buildMachines =
    builtins.map
      (
        conf:
        {
          sshUser = "root";
          sshKey = config.age.secrets.builder-ssh-key.path;
          systems = [ "x86_64-linux" ];
          supportedFeatures = [
            "big-parallel"
          ];
        }
        // conf
      )
      [
        {
          hostName = "auriga";
          publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUU3Vi9GRW9EQmxwQWg3NzM3VjJRcTYzbXA2Nk85WVhMRWRBREIzRVZEMmggcm9vdEBwb3Atb3MK";
          maxJobs = 2;
          speedFactor = 3;
        }
      ];
}
