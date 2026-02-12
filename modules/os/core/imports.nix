{ lib, config, ... }:
{
  flake.modules =
    let
      moduleNames = [
      ];

      getImports = lib.attrVals moduleNames;
    in
    {
      nixos.core.imports = getImports config.flake.modules.nixos;

      darwin.core.imports = getImports config.flake.modules.darwin;
    };
}
