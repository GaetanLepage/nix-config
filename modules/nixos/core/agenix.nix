{ inputs, ... }:
{
  flake.modules.nixos.agenix =
    { config, ... }:
    {
      imports = [
        inputs.agenix.nixosModules.default
        inputs.agenix-rekey.nixosModules.default
      ];

      age.rekey = {
        storageMode = "local";
        masterIdentities = [ ../../../.secrets/identity.age ];
        localStorageDir = ../../../.secrets/${config.networking.hostName};
      };
    };
}
