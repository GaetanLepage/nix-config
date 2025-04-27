{ inputs, config, ... }:
{
  flake.nixosConfigurations =
    let
      mkHost =
        hostname:
        inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs.inputs = inputs;
          modules = [
            # The system configuration
            ../nixos/${hostname}
            config.substituters.module

            # Home manager configuration
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.gaetan.imports = [
                  ../home/hosts/${hostname}
                  config.substituters.module
                ];
                extraSpecialArgs.inputs = inputs;
              };
            }
          ];
        };
    in
    {
      framework = mkHost "framework";
      cuda = mkHost "cuda";
    };
}
