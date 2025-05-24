{ inputs, config, ... }:
let
  config' = config;
in
{
  flake.modules.nixos.homeManager =
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
          ../../../home/hosts/${hostName} # TODO

          config'.flake.modules.homeManager.core
          (config'.flake.modules.homeManager."host_${hostName}" or { })
        ];

        extraSpecialArgs.inputs = inputs;
      };
    };
}
