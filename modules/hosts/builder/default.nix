{ config, ... }:
{
  homeHosts.builder = {
    unstable = true;
    modules = [
      {
        age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJBLqR68XaTkJOZAq2Eb3rRugIHnALgtB64RuDQUSlJQ";

        nix.settings.extra-platforms = [ ];
      }

      config.flake.modules.homeManager.ssh-github
    ];
  };
}
