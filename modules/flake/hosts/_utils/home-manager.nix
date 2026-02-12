{ lib }:
{
  name,
  config,
  ...
}:
{
  options.homeManagerModules = lib.mkOption {
    type = with lib.types; listOf deferredModule;
    default = [ ];
  };

  config = {
    modules = [
      (
        { primaryUser, ... }:
        lib.optionalAttrs (config.homeManagerModules != [ ]) {
          home-manager.users.${primaryUser}.imports = config.homeManagerModules;
        }
      )
    ];
  };
}
