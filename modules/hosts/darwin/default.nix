{
  homeHosts.darwin = {
    unstable = true;
    system = "aarch64-darwin";
    modules = [
      {
        age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHVJ5H2tmG/IG3T1MJDc6GHrEhMHpCWKv+JTY2oxtZp7";
      }
    ];
  };
}
