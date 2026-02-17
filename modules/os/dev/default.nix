flakeArgs:
let
  commonModule =
    { config, primaryUser, ... }:
    {
      imports = [
        ./_substituters.nix
      ];

      users.users.${primaryUser}.shell = config.programs.fish.package;
      programs.fish.enable = true;
      environment.shells = [
        config.programs.fish.package
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
