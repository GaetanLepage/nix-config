flakeArgs:
let
  commonModule =
    { config, primaryUser, ... }:
    {
      imports = [
        ./_substituters.nix
      ];
    };
in
{
  flake.modules.nixos.dev = {
    imports = [
      commonModule
      flakeArgs.config.flake.modules.nixos.home-manager
    ];
  };

  flake.modules.darwin.dev = {
    imports = [
      commonModule
      flakeArgs.config.flake.modules.darwin.home-manager
    ];
  };
}
