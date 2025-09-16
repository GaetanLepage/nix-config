{ inputs, ... }:
{
  flake.modules.homeManager.agenix =
    { config, ... }:
    {
      imports = [
        inputs.agenix.homeManagerModules.default
        inputs.agenix-rekey.homeManagerModules.default
      ];

      age.rekey = {
        storageMode = "local";
        masterIdentities = [ ../../../.secrets/identity.age ];
        localStorageDir = ../../../.secrets/${config.networking.hostName};
      };
    };
}
