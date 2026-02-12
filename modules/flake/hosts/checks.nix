{
  config,
  ...
}:
{
  perSystem =
    {
      pkgs,
      lib,
      system,
      ...
    }:
    {
      checks =
        let
          filterSystem = lib.filterAttrs (n: cfg: cfg.system == system);

          extractChecks =
            name: configs:
            pkgs.symlinkJoin {
              name = "${name}-checks";
              paths = lib.pipe configs [
                filterSystem
                (lib.mapAttrsToList (_: cfg: cfg.finalPackage))
              ];
            };
        in
        lib.mapAttrs extractChecks {
          nixos-hosts = config.nixosHosts;
          home-hosts = config.homeHosts;
        };
    };
}
