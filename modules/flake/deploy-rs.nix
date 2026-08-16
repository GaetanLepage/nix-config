{
  lib,
  inputs,
  self,
  config,
  ...
}:
let
  inherit (inputs) deploy-rs;
in
{
  flake = {
    deploy.nodes = lib.mapAttrs (hostname: options: {
      inherit hostname;
      profiles.system = {
        user = "root";
        path = deploy-rs.lib.${options.system}.activate.nixos self.nixosConfigurations.${hostname};
      };
    }) config.nixosHosts;
  };

  perSystem =
    {
      system,
      inputs',
      ...
    }:
    {
      # Only check the nodes which are built for the current system, otherwise `nix flake check`
      # pulls in (and thus builds) the configurations of foreign-architecture hosts.
      checks = deploy-rs.lib.${system}.deployChecks (
        self.deploy
        // {
          nodes = lib.filterAttrs (
            hostname: _: config.nixosHosts.${hostname}.system == system
          ) self.deploy.nodes;
        }
      );

      devshells.default.packages = [
        inputs'.deploy-rs.packages.default
      ];
    };
}
