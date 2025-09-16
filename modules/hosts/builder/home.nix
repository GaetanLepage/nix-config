{
  flake.modules.homeManager.host_builder =
    {
      pkgs,
      config,
      ...
    }:
    {
      programs = {
        nh.flake = "github:GaetanLepage/nix-config#builder";
      };

      nix.package = pkgs.nix;

      age.secrets.foo.rekeyFile = ./foo.age;
      home.file.foo.text = ''
        ${config.age.secrets.foo.path}
      '';
      age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJBLqR68XaTkJOZAq2Eb3rRugIHnALgtB64RuDQUSlJQ";
    };
}
