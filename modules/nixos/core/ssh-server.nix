{
  flake.modules.nixos.ssh-server = {
    services.openssh = {
      enable = true;

      settings.PasswordAuthentication = false;
    };

    users.users =
      let
        persoKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEJSonNBBb1DlhaO4EfMh3TbIIsV25phZQ9vp/qKOw9E";
      in
      {
        gaetan.openssh.authorizedKeys.keys = [ persoKey ];
        root.openssh.authorizedKeys.keys = [ persoKey ];
      };
  };
}
