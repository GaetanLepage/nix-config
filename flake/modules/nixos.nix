{
  inputs,
  lib,
  config,
  ...
}:
let
  inherit (lib) types mkOption;
in
{
  options = {
    nixosHosts =
      let
        nixosHostType = types.submodule {
          options = {
            buildLocally = lib.mkEnableOption "";

            hasHM = lib.mkEnableOption "";

            system = mkOption {
              type = types.str;
              default = "x86_64-linux";
            };
          };
        };
      in
      mkOption {
        type = types.attrsOf nixosHostType;
      };
  };

  config = {
    flake.nixosConfigurations =
      let
        mkHost =
          hostname: options:
          inputs.nixpkgs.lib.nixosSystem {
            inherit (options) system;
            specialArgs.inputs = inputs;
            modules =
              [
                # The system configuration
                ../../nixos/${hostname}

                config.substituters.module
              ]
              ++ lib.optionals options.hasHM [
                # Home manager configuration
                inputs.home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.gaetan.imports = [
                      ../../home/hosts/${hostname}

                      config.substituters.module
                    ];
                    extraSpecialArgs.inputs = inputs;
                  };
                }
              ];
          };
      in
      lib.mapAttrs mkHost config.nixosHosts;
  };
}
