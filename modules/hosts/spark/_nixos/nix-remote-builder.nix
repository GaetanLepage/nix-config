{
  users = {
    users.nix = {
      isNormalUser = true;
      group = "nix";

      openssh.authorizedKeys.keys = [
        # nix-community
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOupOoulINUeCUKLfBllcS1Rulc1LzYnIOITXqEyYaao"
      ];
    };
    groups.nix = { };
  };

  nix.settings.trusted-users = [ "nix" ];
}
