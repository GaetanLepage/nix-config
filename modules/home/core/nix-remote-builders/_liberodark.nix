{ config, ... }:
{
  nix.buildMachines =
    let
      sshUser = "gaetan";
      sshKey = "/run/user/1000/agenix/ssh-liberodark";
    in
    [
      {
        # Liberodark arm builder
        hostName = config.programs.ssh.settings.arm-liberodark.data.HostName;
        inherit sshUser sshKey;
        # base64 -w0 -i /etc/ssh/ssh_host_ed25519_key.pub
        publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUVCNjZqeTVhWWp2MUptYU9BbERzWUhkRkNDV29lMlhaeUhJS2U0cHNaOU8gcm9vdEBuaXhvcwo";
        maxJobs = 2;
        speedFactor = 1;
        systems = [
          "aarch64-linux"
        ];
        supportedFeatures = [
          "benchmark"
          # "big-parallel"
          "kvm"
          "nixos-test"
        ];
      }
      {
        # Liberodark darwin builder
        hostName = config.programs.ssh.settings.darwin.data.HostName;
        inherit sshUser sshKey;
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
    ];
}
