{config, ...}: {
  age.secrets.alya-remote-builder-ssh-key.file = ../../secrets/ssh/alya_remote_builder.age;

  nix = {
    distributedBuilds = true;
    buildMachines = [
      # {
      #   hostName = "10.10.10.5";
      #   sshUser = "nix";
      #   system = "x86_64-linux";
      #   maxJobs = 12;
      #   supportedFeatures = [
      #     "kvm"
      #     "big-parallel"
      #     "benchmark"
      #   ];
      # }
      {
        hostName = "10.10.10.4";
        sshUser = "root";
        sshKey = config.age.secrets.alya-remote-builder-ssh-key.path;
        system = "x86_64-linux";
        maxJobs = 16;
        supportedFeatures = [
          "kvm"
          "big-parallel"
          "benchmark"
        ];
      }
    ];
  };
}
