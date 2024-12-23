{
  users = {
    users.nix = {
      isNormalUser = true;
      group = "nix";

      openssh.authorizedKeys.keys = [
        # cuda-remote-builder
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK5GFEjOpI2l0ow8SqIkC9C7x8sWBexgHAnGpGlLSZKl"
      ];
    };
    groups.nix = { };
  };

  nix.settings.trusted-users = [ "nix" ];
}
