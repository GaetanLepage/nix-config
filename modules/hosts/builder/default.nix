{ config, ... }:
{
  homeHosts.builder = {
    unstable = true;
    system = "x86_64-linux";
    modules = [
      {
        age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJBLqR68XaTkJOZAq2Eb3rRugIHnALgtB64RuDQUSlJQ";

        nix.settings.extra-platforms = [ ];
      }

      config.flake.modules.homeManager.ssh-github
    ];
  };
}
