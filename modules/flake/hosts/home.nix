{
  inputs,
  lib,
  config,
  self,
  ...
}:
let
  inherit (lib) types mkOption;
  inherit (import ./_utils { inherit lib inputs; }) baseHostModule;
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
              finalPackage = self.homeConfigurations.${name}.activationPackage;

              specialArgs = {
                configName = name;
                nhSwitchCommand = "nh home switch --configuration ${name}";
              };

              modules = [
                config.flake.modules.homeManager.core
                (
                  { pkgs, config, ... }:
                  {
                    home.homeDirectory =
                      let
                        inherit (pkgs.stdenv) hostPlatform;
                        prefix =
                          if hostPlatform.isLinux then
                            "home"
                          else if hostPlatform.isDarwin then
                            "Users"
                          else
                            throw "Invalid hostPlatform: ${hostPlatform}";
                      in
                      "/${prefix}/${config.home.username}";

                    nix.package = pkgs.nix;

                    age.identityPaths = [ "${config.home.homeDirectory}/.ssh/agenix" ];
                  }
                )
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
    flake.homeConfigurations =
      let
        mkHost =
          configName: options:
          inputs.home-manager.lib.homeManagerConfiguration {
            extraSpecialArgs = options.specialArgs;
            inherit (options) pkgs modules;
          };
      in
      lib.mapAttrs mkHost config.homeHosts;
  };
}
