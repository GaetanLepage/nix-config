{config, ...}: {
  age.secrets = {
    aarch64-build-box-ssh-key.rekeyFile = ./ssh-keys/aarch64-build-box.age;
    darwin-build-box-ssh-key.rekeyFile = ./ssh-keys/darwin-build-box.age;
    linux-build-box-ssh-key.rekeyFile = ./ssh-keys/linux-build-box.age;
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
          "benchmark"
          "big-parallel"
          "kvm"
          "nixos-test"
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
        supportedFeatures = [
          "big-parallel"
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
          # Disable `x86_64-linux` because there is no point in using a remote builder instead of the local machine.
          # "x86_64-linux"
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
