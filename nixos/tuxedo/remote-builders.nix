{config, ...}: {
  age.secrets = {
    alya-remote-builder-ssh-key.file = ../../secrets/ssh/alya-remote-builder.age;
    cuda-remote-builder-ssh-key.file = ../../secrets/ssh/cuda-remote-builder.age;
    aarch64-build-box-ssh-key.file = ../../secrets/ssh/aarch64-build-box.age;
    darwin-build-box-ssh-key.file = ../../secrets/ssh/darwin-build-box.age;
    linux-build-box-ssh-key.file = ../../secrets/ssh/linux-build-box.age;
  };

  nix = {
    distributedBuilds = true;

    # Nix will instruct remote build machines to use their own binary substitutes if available.
    # In practical terms, this means that remote hosts will fetch as many build dependencies as
    # possible from their own substitutes (e.g, from cache.nixos.org), instead of waiting for this
    # host to upload them all. This can drastically reduce build times if the network connection
    # between this computer and the remote build host is slow.
    settings.builders-use-substitutes = true;

    buildMachines = [
      {
        # cuda
        hostName = "10.10.10.5";
        sshUser = "nix";
        sshKey = config.age.secrets.cuda-remote-builder-ssh-key.path;
        publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSURKMjVOWVVUSHRuTlpZOVdDYW12OFpHYzAwekc0RXFKaHllam8zVG1xT3UK";
        system = "x86_64-linux";
        maxJobs = 12;
        supportedFeatures = [
          "kvm"
          "big-parallel"
          "benchmark"
        ];
      }
      {
        # Alya
        hostName = "10.10.10.4";
        sshUser = "root";
        sshKey = config.age.secrets.alya-remote-builder-ssh-key.path;
        publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUxLTnozOWJFSzR4M1JWeHEvekFyb1A2ZE13VFdUd2FabTBJUi9lTmFJeHYK";
        system = "x86_64-linux";
        maxJobs = 16;
        supportedFeatures = [
          "kvm"
          "big-parallel"
          "benchmark"
        ];
      }
      {
        # ARM build box
        hostName = "aarch64.nixos.community";
        sshUser = "glepage";
        sshKey = config.age.secrets.aarch64-build-box-ssh-key.path;
        publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSU1VVHo1aTl1NUgyRkhOQW1aSnlvSmZJR3lVbS9IZkdoZnduYzE0MkwzZHMK";
        systems = [
          "aarch64-linux"
        ];
        maxJobs = 64;
        supportedFeatures = [
          "big-parallel"
        ];
      }
      {
        # Darwin build box
        hostName = "darwin-build-box.nix-community.org";
        sshUser = "glepage";
        sshKey = config.age.secrets.darwin-build-box-ssh-key.path;
        publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUtYN1cxenR6QXRWWFQrTkJNSVRVK0pMWGNJRTVIVEVPZDdRM2ZRTnU4MFMK";
        maxJobs = 32;
        systems = [
          "aarch64-darwin"
          "x86_64-darwin"
        ];
      }
      {
        # Linux build box
        hostName = "build-box.nix-community.org";
        sshUser = "glepage";
        sshKey = config.age.secrets.linux-build-box-ssh-key.path;
        publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUVsSVE1NHFBeTdEaDYzckJ1ZFlLZGJ6SkhycmJyck1YTFlsN1BrbWs4OEgK";
        maxJobs = 16;
        systems = [
          "i686-linux"
          "riscv64-linux"
          "x86_64-linux"
        ];
        supportedFeatures = [
          "benchmark"
          "big-parallel"
          "kvm"
          "nixos-test"
        ];
      }
    ];
  };
}
