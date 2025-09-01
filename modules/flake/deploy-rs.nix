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
      checks = deploy-rs.lib.${system}.deployChecks self.deploy;

      devshells.default.packages = [
        inputs'.deploy-rs.packages.default
      ];
    };
}
