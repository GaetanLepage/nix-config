{
  lib,
  config,
  inputs,
  ...
}:
let
  hostToColmena = targetHost: options: {
    deployment = {
      inherit targetHost;
      inherit (options) tags;
    };
    imports = options.modules;
  };
in
{
  flake.colmenaHive = inputs.colmena.lib.makeHive (
    {
      meta = {
        # Only used internally in colmenia as we override nixpkgs for all hosts
        nixpkgs = import inputs.nixpkgs { system = "x86_64-linux"; };

        specialArgs.inputs = inputs;
        nodeNixpkgs = lib.mapAttrs (_: builtins.getAttr "pkgs") config.nixosHosts;
      };
    }
    // (lib.mapAttrs hostToColmena config.nixosHosts)
  );

  perSystem =
    {
      system,
      inputs',
      ...
    }:
    {
      devshells.default.packages = [
        inputs'.colmena.packages.colmena
      ];
    };
}
