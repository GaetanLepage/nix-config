flakeArgs:
let
  inherit (flakeArgs.lib) types mapAttrs mkOption;
  inherit (import ./_utils { inherit (flakeArgs) lib inputs; }) baseHostModule homeManagerModule;
in
{
  options = {
    darwinHosts =
      let
        hostType = types.submodule [
          baseHostModule
          homeManagerModule
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
                flakeArgs.config.flake.modules.darwin.core
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
