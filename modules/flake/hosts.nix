{
  inputs,
  lib,
  config,
  self,
  ...
}@flakeArgs:
let
  inherit (lib) types mkOption;
in
{
  options =
    let
      baseHostModule =
        { config, name, ... }:
        {
          options = {
            system = mkOption {
              type = types.str;
              default = "x86_64-linux";
            };

            unstable = lib.mkOption {
              type = types.bool;
            };

            modules = lib.mkOption {
              type = with types; listOf deferredModule;
              default = [ ];
            };

            nixpkgs = lib.mkOption {
              type = types.pathInStore;
            };
            pkgs = lib.mkOption {
              type = types.pkgs;
            };

            # Contains the final package for this configuration
            package = lib.mkOption {
              type = types.package;
            };
          };
          config = {
            nixpkgs = if config.unstable then inputs.nixpkgs else inputs.nixpkgs-stable;
            pkgs = import config.nixpkgs {
              inherit (config) system;
              config.allowUnfree = true;
            };
          };
        };

      hostTypeNixos = types.submodule [
        baseHostModule
        (
          { name, ... }:
          {
            modules = [
              config.flake.modules.nixos.core
              { networking.hostName = name; }
              (config.flake.modules.nixos."host_${name}" or { })
            ];
            package = self.nixosConfigurations.${name}.config.system.build.toplevel;
          }
        )
      ];
      hostTypeHomeManager = types.submodule [
        baseHostModule
        (
          { name, ... }:
          {
            modules = [
              config.flake.modules.homeManager.core
              (
                { pkgs, config, ... }:
                {
                  nix.package = pkgs.nix;
                  age.identityPaths = [ "${config.home.homeDirectory}/.ssh/agenix" ];
                }
              )
            ];
            package = self.homeConfigurations.${name}.activationPackage;
          }
        )
      ];
    in
    {
      nixosHosts = mkOption { type = types.attrsOf hostTypeNixos; };
      homeHosts = mkOption { type = types.attrsOf hostTypeHomeManager; };
    };

  config = {
    flake = {
      nixosConfigurations =
        let
          mkHost =
            hostname: options:

            options.nixpkgs.lib.nixosSystem {
              inherit (options) system modules;
              specialArgs.inputs = inputs;
            };
        in
        lib.mapAttrs mkHost config.nixosHosts;

      homeConfigurations =
        let
          mkHost =
            configName: options:
            inputs.home-manager.lib.homeManagerConfiguration {
              extraSpecialArgs = {
                inputs = inputs;
                inherit configName;
                nhSwitchCommand = "nh home switch --configuration ${configName}";
              };
              inherit (options) pkgs modules;
            };
        in
        lib.mapAttrs mkHost config.homeHosts;
    };

    perSystem =
      {
        pkgs,
        lib,
        system,
        ...
      }:
      {
        checks =
          let
            filterSystem = lib.filterAttrs (n: cfg: cfg.system == system);

            extractChecks =
              name: configs:
              pkgs.symlinkJoin {
                name = "${name}-checks";
                paths = lib.pipe configs [
                  filterSystem
                  (lib.mapAttrsToList (_: cfg: cfg.package))
                ];
              };
          in
          lib.mapAttrs extractChecks {
            nixos-hosts = config.nixosHosts;
            home-hosts = config.homeHosts;
          };
      };
  };
}
