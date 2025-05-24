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
            hasHM = lib.mkEnableOption "";

            system = mkOption {
              type = types.str;
              default = "x86_64-linux";
            };

            unstable = lib.mkOption {
              type = types.bool;
            };

            deploy = {
              remoteBuild = lib.mkEnableOption "";
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
          let
            nixpkgs' = if options.unstable then inputs.nixpkgs else inputs.nixpkgs-stable;
          in
          nixpkgs'.lib.nixosSystem {
            inherit (options) system;
            specialArgs.inputs = inputs;
            modules =
              [
                # The system configuration
                ../../nixos/${hostname}
                ../../nixos/_modules

                config.flake.modules.nixos.core
                (config.flake.modules.nixos."host_${hostname}" or { })
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

                      config.flake.modules.homeManager.core
                      (config.flake.modules.homeManager."host_${hostname}" or { })
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
