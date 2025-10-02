{
  homeHosts.builder = {
    modules = [
      {
        age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJBLqR68XaTkJOZAq2Eb3rRugIHnALgtB64RuDQUSlJQ";

        nix.settings.extra-platforms = [ ];
      }

      ./_gitub-ssh-auth.nix
    ];
  };
}
