{config, ...}: {
  age.secrets = {
    alya-remote-builder-ssh-key.file = ../../secrets/ssh/alya_remote_builder.age;
    darwin-build-box-ssh-key.file = ../../secrets/ssh/darwin-build-box.age;
  };

  nix = {
    distributedBuilds = true;
    buildMachines = [
      # cuda
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
      # Alya
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
      # Darwin
      {
        hostName = "darwin-build-box.nix-community.org";
        sshUser = "glepage";
        sshKey = config.age.secrets.darwin-build-box-ssh-key.path;
        publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUtYN1cxenR6QXRWWFQrTkJNSVRVK0pMWGNJRTVIVEVPZDdRM2ZRTnU4MFMK";
        systems = [
          "aarch64-darwin"
          "x86_64-darwin"
        ];
      }
    ];
  };
}
