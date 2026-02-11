{
  homeHosts.jrs = {
    unstable = true;
    system = "x86_64-linux";
    modules = [
      {
        home.username = "glepage";

        age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINPJUBDYovyTl2N+iWzAn7A24AMSArAuFigY16D/5U+J";
      }
    ];
  };
}
