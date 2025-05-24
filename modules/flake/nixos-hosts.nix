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

            imports = lib.mkOption {
              type = types.listOf types.anything; # TODO
              default = [ ];
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
            modules = [
              # The system configuration
              ../../nixos/${hostname} # TODO
              ../../nixos/_modules # TODO

              config.flake.modules.nixos.core
            ] ++ options.imports;
          };
      in
      lib.mapAttrs mkHost config.nixosHosts;
  };
}
