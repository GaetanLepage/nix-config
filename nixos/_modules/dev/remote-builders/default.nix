{
  lib,
  config,
  ...
}:
let
  cfg = config.my-modules.dev.remoteBuilders;
in
{
  options = {
    my-modules.dev.remoteBuilders = {
      enable = lib.mkEnableOption "";

      linuxMaxJobs = lib.mkOption {
        type = lib.types.ints.unsigned;
        default = 8;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    age.secrets =
      lib.mapAttrs
        (n: v: {
          inherit (v) rekeyFile;
          owner = "gaetan";
        })
        {
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
          hostName = "aarch64-build-box.nix-community.org";
          sshUser = "glepage";
          sshKey = config.age.secrets.linux-build-box-ssh-key.path;
          # base64 -w0 /etc/ssh/ssh_host_ed25519_key.pub
          publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUc5dXlmaHlsaStCUnRrNjR5K25pcXRiK3NLcXVSR0daODdmNFlSYzhFRTEK";
          systems = [
            "aarch64-linux"
          ];
          maxJobs = 20;
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
          # base64 -w0 -i /etc/ssh/ssh_host_ed25519_key.pub
          publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUtNSGhsY243ZlVwVXVpT0ZlSWhEcUJ6Qk5Gc2JOcXErTnB6dUdYM2U2enYgCg==";
          maxJobs = 8;
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
          sshUser = "glepage";
          sshKey = config.age.secrets.linux-build-box-ssh-key.path;
          # base64 -w0 /etc/ssh/ssh_host_ed25519_key.pub
          publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUVsSVE1NHFBeTdEaDYzckJ1ZFlLZGJ6SkhycmJyck1YTFlsN1BrbWs4OEgK";
          maxJobs = cfg.linuxMaxJobs;
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
