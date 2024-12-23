{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) types;

  cfg = config.services.kanshi;
in
{
  options = {
    services.kanshi =
      let
        screenType = types.submodule {
          options =
            lib.mapAttrs
              (
                _: props:
                lib.mkOption (
                  {
                    inherit (props) type;
                  }
                  // lib.optionalAttrs (props ? default) {
                    inherit (props) default;
                  }
                )
              )
              {
                criteria.type = types.str;
                status = {
                  type = types.enum [
                    "enable"
                    "disable"
                  ];
                  default = "disable";
                };
                scale = {
                  type = types.float;
                  default = 1.0;
                };
                position = {
                  type = types.str;
                  default = "0,0";
                };
                mode.type = types.str;
              };
        };
      in
      {
        screens = lib.mkOption {
          type = types.attrsOf screenType;
        };

        _profiles = lib.mkOption {
          type = types.attrsOf (
            types.submodule {
              options = {
                screens = lib.mkOption {
                  type = with types; attrsOf anything;
                };
                wifi = lib.mkEnableOption "wifi";
              };
            }
          );
        };
      };
  };

  config = {
    services.kanshi = {
      settings =
        let
          mkWifiHook =
            on: "${lib.getExe' pkgs.networkmanager "nmcli"} radio wifi ${if on then "on" else "off"}";
        in
        lib.mapAttrsToList (name: props: {
          profile = {
            inherit name;
            exec = mkWifiHook props.wifi;
            outputs = lib.mapAttrsToList (
              name: props:
              let
                defaults = cfg.screens.${name};
                overrides = lib.filterAttrs (_: v: v != null) props;
              in
              defaults // overrides
            ) props.screens;
          };
        }) cfg._profiles;
    };
  };
}
