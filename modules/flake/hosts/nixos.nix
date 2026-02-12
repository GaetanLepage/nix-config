{
  inputs,
  lib,
  config,
  self,
  ...
}:
let
  inherit (lib) types mkOption;
  inherit (import ./_utils { inherit lib inputs; }) baseHostModule homeManagerModule;
in
{
  options = {
    nixosHosts =
      let
        hostType = types.submodule [
          baseHostModule
          homeManagerModule
          (
            { name, ... }:
            {
              system = lib.mkDefault "x86_64-linux";
              finalPackage = self.nixosConfigurations.${name}.config.system.build.toplevel;

              modules = [
                config.flake.modules.nixos.core
                { networking.hostName = name; }
              ];
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
    flake.nixosConfigurations =
      let
        mkHost =
          hostname: options:

          options.nixpkgs.lib.nixosSystem {
            inherit (options)
              system
              modules
              specialArgs
              ;
          };
      in
      lib.mapAttrs mkHost config.nixosHosts;
  };
}
