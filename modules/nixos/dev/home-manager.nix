topLevel@{ inputs, ... }:
{
  flake.modules.nixos.home-manager =
    { config, ... }:
    let
      inherit (config.networking) hostname;
    in
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.gaetan.imports = [
          ../../../home/hosts/${hostname} # TODO

          topLevel.config.flake.modules.homeManager.core
          (topLevel.config.flake.modules.homeManager."host_${hostname}" or { })
        ];

        extraSpecialArgs.inputs = inputs;
      };
    };
}
