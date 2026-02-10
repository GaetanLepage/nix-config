{ lib, inputs }:
let
  inherit (lib)
    mkOption
    types
    ;
  baseHostModule =
    { config, name, ... }:
    {
      options = {
        system = mkOption {
          type = types.str;
          default = "x86_64-linux";
        };

        unstable = mkOption {
          type = types.bool;
        };

        modules = mkOption {
          type = with types; listOf deferredModule;
          default = [ ];
        };

        nixpkgs = mkOption {
          type = types.pathInStore;
        };
        pkgs = mkOption {
          type = types.pkgs;
        };

        # Contains the final package for this configuration
        package = mkOption {
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
in
baseHostModule
