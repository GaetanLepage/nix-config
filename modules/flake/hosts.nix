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
  options =
    let
      hostType = types.submodule {
        options = {
          system = mkOption {
            type = types.str;
            default = "x86_64-linux";
          };

          unstable = lib.mkOption {
            type = types.bool;
          };
        };
      };
    in
    {
      nixosHosts = mkOption { type = types.attrsOf hostType; };
      homeHosts = mkOption { type = types.attrsOf hostType; };
    };

  config = {
    flake = {
      nixosConfigurations =
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
                config.flake.modules.nixos.core
                (config.flake.modules.nixos."host_${hostname}" or { })
              ];
            };
        in
        lib.mapAttrs mkHost config.nixosHosts;

      homeConfigurations =
        let
          mkHost =
            configName: options:
            inputs.home-manager.lib.homeManagerConfiguration {
              pkgs = import inputs.nixpkgs {
                inherit (options) system;
                config = {
                  allowUnfree = true;
                };
              };

              extraSpecialArgs = {
                inputs = inputs;
                inherit configName;
              };
              modules = [
                config.flake.modules.homeManager.core
                (config.flake.modules.homeManager."host_${configName}" or { })
                (
                  { pkgs, ... }:
                  {
                    programs.nh.flake = "github:GaetanLepage/nix-config";
                    nix.package = pkgs.nix;
                  }
                )
              ];
            };
        in
        lib.mapAttrs mkHost config.homeHosts;
    };
  };
}
