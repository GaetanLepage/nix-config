{
  flake.modules.homeManager.core = {
    imports = [
      ./_ssh
    ];

    nix = {
      distributedBuilds = true;

      settings.builders-use-substitutes = true;

      buildMachines =
        let
          sshUser = "glepage";
          sshKey = "/run/user/1000/agenix/ssh-nix-community";
        in
        [
          {
            # ARM build box
            hostName = "aarch64-build-box.nix-community.org";
            inherit sshUser sshKey;
            # base64 -w0 /etc/ssh/ssh_host_ed25519_key.pub
            publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUc5dXlmaHlsaStCUnRrNjR5K25pcXRiK3NLcXVSR0daODdmNFlSYzhFRTEK";
            systems = [ "aarch64-linux" ];
            maxJobs = 3;
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
            inherit sshUser sshKey;
            # base64 -w0 -i /etc/ssh/ssh_host_ed25519_key.pub
            publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUtNSGhsY243ZlVwVXVpT0ZlSWhEcUJ6Qk5Gc2JOcXErTnB6dUdYM2U2enYgCg==";
            maxJobs = 4;
            speedFactor = 1;
            systems = [
              "aarch64-darwin"
              "x86_64-darwin"
            ];
            supportedFeatures = [
              "apple-virt"
              "big-parallel"
              "nixos-test"
            ];
          }
          {
            # Linux build box
            hostName = "build-box.nix-community.org";
            inherit sshUser sshKey;
            # base64 -w0 /etc/ssh/ssh_host_ed25519_key.pub
            publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUVsSVE1NHFBeTdEaDYzckJ1ZFlLZGJ6SkhycmJyck1YTFlsN1BrbWs4OEgK";
            maxJobs = 0;
            speedFactor = 1;
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
  };
}
