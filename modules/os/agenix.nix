{ inputs, ... }:
{
  flake.modules =
    let
      commonModule =
        { config, ... }:
        {
          imports = [
            # agenix-rekey's module should be agnostic and works on both NixOS and nix-darwin
            inputs.agenix-rekey.nixosModules.default
          ];

          age.rekey = {
            storageMode = "local";
            masterIdentities = [ ../../.secrets/identity.age ];
            localStorageDir = ../../.secrets/nixos/${config.networking.hostName};
          };
        };
    in
    {
      nixos.agenix.imports = [
        inputs.agenix.nixosModules.default
        commonModule
      ];

      darwin.agenix.imports = [
        inputs.agenix.darwinModules.default
        commonModule
      ];
    };
}
