{
  inputs,
  self,
  ...
}:
let
  inherit (inputs) deploy-rs;
in
{
  flake.deploy.nodes = {
    framework = {
      hostname = "framework";
      profiles.system = {
        user = "root";
        path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.framework;
      };
    };
    cuda = {
      hostname = "cuda";
      profiles.system = {
        user = "root";
        path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.cuda;
      };
    };
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
