/*
  Defines the flake.modules.{nixos,darwin}.home-manager NixOS and nix-darwin modules, which:
  - enables home-manager for the main user
  - initializes the agenix-home-secret-key used to decrypt the rest of the home-manager agenix secrets
  - imports all flake.modules.homeManager.host_${hostName} modules
*/
flakeArgs: {
  flake.modules =
    let
      commonModule =
        { config, primaryUser, ... }:
        {
          age.secrets.agenix-home-secret-key = {
            rekeyFile = ./agenix-home-secret-key.age;
            owner = primaryUser;
          };

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit (flakeArgs) inputs;
              inherit primaryUser;
            };

            users.${primaryUser} = {
              imports = [
                flakeArgs.config.flake.modules.homeManager.core
              ];

              # Ensure that the NixOS's HOMEDIR for this user is the same as home-manager's
              home.homeDirectory = config.users.users.${primaryUser}.home;

              age = {
                identityPaths = [ config.age.secrets.agenix-home-secret-key.path ];
                rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBE+2at1NN5ahYloIOYXyEhGi6lRN4PoapQz6CNoTo0r";
              };
            };
          };
        };
    in
    {
      nixos.home-manager =
        { config, ... }:
        {
          imports = [
            flakeArgs.inputs.home-manager.nixosModules.home-manager
            commonModule
          ];

          home-manager.extraSpecialArgs = {
            configName = "nixos_${config.networking.hostName}";
            nhSwitchCommand = "nh os switch";
          };
        };

      darwin.home-manager =
        { config, ... }:
        {
          imports = [
            flakeArgs.inputs.home-manager.darwinModules.home-manager
            commonModule
          ];

          home-manager.extraSpecialArgs = {
            configName = "darwin_${config.networking.hostName}";
            nhSwitchCommand = "nh darwin switch";
          };
        };
    };
}
