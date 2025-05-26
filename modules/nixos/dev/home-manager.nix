topLevel@{ inputs, ... }:
{
  flake.modules.nixos.home-manager =
    { config, ... }:
    let
      inherit (config.networking) hostName;
    in
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.gaetan.imports = [
          topLevel.config.flake.modules.homeManager.core
          (topLevel.config.flake.modules.homeManager."host_${hostName}" or { })
        ];

        extraSpecialArgs.inputs = inputs;
      };
    };
}
