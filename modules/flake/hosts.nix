{
  inputs,
  lib,
  config,
  self,
  ...
}:
let
  inherit (lib) types mkOption;
in
{
  options =
    let
      baseHostModule =
        { config, ... }:
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
          }
        )
      ];
      hostTypeHomeManager = types.submodule [
        baseHostModule
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
        }
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
      { pkgs, ... }:
      {
        checks = {
          nixos-hosts = pkgs.symlinkJoin {
            name = "nixos-hosts-checks";
            paths = lib.mapAttrsToList (_: cfg: cfg.config.system.build.toplevel) self.nixosConfigurations;
          };
          home-hosts = pkgs.symlinkJoin {
            name = "home-hosts-checks";
            paths = lib.mapAttrsToList (_: cfg: cfg.activationPackage) self.homeConfigurations;
          };
        };
      };
  };
}
