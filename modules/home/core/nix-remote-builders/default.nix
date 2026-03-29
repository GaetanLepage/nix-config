{
  flake.modules.homeManager.core =
    { config, ... }:
    {
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

            commonLinuxFeatures = [
              "benchmark"
              "big-parallel"
              "kvm"
              "nixos-test"
            ];
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
              supportedFeatures = commonLinuxFeatures;
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
              supportedFeatures = commonLinuxFeatures;
            }
            {
              # Liberodark darwin builder
              hostName = config.programs.ssh.matchBlocks.darwin.data.hostname;
              sshUser = "gaetan";
              sshKey = "/run/user/1000/agenix/ssh-liberodark";
              # base64 -w0 -i /etc/ssh/ssh_host_ed25519_key.pub
              publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUhWSjVIMnRtRy9JRzNUMU1KRGM2R0hyRWhNSHBDV0t2K0pUWTJveHRacDcgCg==";
              maxJobs = 4;
              speedFactor = 2;
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
              # Ada (nixos-community)
              hostName = "ada.nixos-cuda.org";
              sshUser = "nix";
              inherit sshKey;
              # base64 -w0 /etc/ssh/ssh_host_ed25519_key.pub
              publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUp1RjdhSkZydXJUUHBMNjIxZU5mWlkxR2J0cHZhTkxIVlZKcTdKdDZ0YzYgcm9vdEBhZGEK";
              maxJobs = 1;
              speedFactor = 1;
              systems = [
                "x86_64-linux"
              ];
              supportedFeatures = commonLinuxFeatures ++ [ "cuda" ];
              mandatoryFeatures = [ "cuda" ];
            }
          ];
      };
    };
}
