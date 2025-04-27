{
  lib,
  config,
  ...
}:
let
  inherit (lib) types mkOption;

  cfg = config.substituters;

  substituterType = types.submodule {
    options = {
      priority = mkOption {
        type = types.ints.unsigned;
      };

      url = mkOption {
        type = types.str;
      };

      publicKey = mkOption {
        type = types.str;
      };
    };
  };
in
{
  options.substituters = {
    definitions = mkOption {
      type = types.listOf substituterType;
    };

    module = mkOption {
      type = types.anything;
    };
  };

  config = {
    substituters.module.nix.settings = {
      trusted-public-keys = builtins.catAttrs "publicKey" cfg.definitions;

      substituters = builtins.map (def: "${def.url}?priority=${toString def.priority}") cfg.definitions;
    };
  };
}
