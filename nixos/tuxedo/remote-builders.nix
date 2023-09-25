{
  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "10.10.10.5";
        sshUser = "nix";
        system = "x86_64-linux";
        maxJobs = 12;
        supportedFeatures = [
          "kvm"
          "big-parallel"
          "benchmark"
        ];
      }
    ];
  };
}
