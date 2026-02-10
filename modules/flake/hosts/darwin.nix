flakeArgs:
let
  inherit (flakeArgs.lib) types mapAttrs mkOption;
  baseHostModule = import ./_base-host-module.nix { inherit (flakeArgs) lib inputs; };
in
{
  options = {
    darwinHosts =
      let
        hostType = types.submodule [
          baseHostModule
          (
            {
              name,
              lib,
              config,
              ...
            }:
            {
              system = lib.mkDefault "aarch64-darwin";
              finalPackage = flakeArgs.self.darwinConfigurations.${name}.config.system.build.toplevel;

              modules = [
                {
                  networking.hostName = name;
                  nixpkgs.hostPlatform = config.system;
                  system.primaryUser = config.primaryUser;
                }
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
    flake.darwinConfigurations =
      let
        mkHost =
          configName: options:
          flakeArgs.inputs.nix-darwin.lib.darwinSystem {
            inherit (options)
              pkgs
              modules
              specialArgs
              ;
          };
      in
      mapAttrs mkHost flakeArgs.config.darwinHosts;
  };
}
