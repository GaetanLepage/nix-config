{
  flake.modules.nixos.security = {

    # environment.shellAliases.sudo = "doas";

    security = {
      # TODO: revert to original command when https://github.com/NixOS/nix/issues/10202 is fixed
      # sudo.enable = false;
      sudo = {
        enable = true;
        wheelNeedsPassword = false;
      };
      doas = {
        enable = true;
        wheelNeedsPassword = false;
      };
    };
  };
}
