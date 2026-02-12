{
  inputs,
  lib,
  config,
  self,
  ...
}:
let
  inherit (lib) types mkOption;
  baseHostModule = import ./_base-host-module.nix { inherit lib inputs; };
in
{
  options = {
    homeHosts =
      let
        hostType = types.submodule [
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
              finalPackage = self.homeConfigurations.${name}.activationPackage;
            }
          )
        ];
      in
      mkOption {
        type = types.attrsOf hostType;
        default = { };
      };
  };

  config = {
    flake.homeConfigurations =
      let
        mkHost =
          configName: options:
          inputs.home-manager.lib.homeManagerConfiguration {
            extraSpecialArgs = {
              inherit
                inputs
                configName
                ;
              nhSwitchCommand = "nh home switch --configuration ${configName}";
              inherit (options) primaryUser;
            };
            inherit (options) pkgs modules;
          };
      in
      lib.mapAttrs mkHost config.homeHosts;
  };
}
