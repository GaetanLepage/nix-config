flakeArgs: {
  flake.modules.nixos.home-manager =
    { config, primaryUser, ... }:
    let
      inherit (config.networking) hostName;
    in
    {
      imports = [
        flakeArgs.inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.${primaryUser}.imports = [
          flakeArgs.config.flake.modules.homeManager.core
          {
            # Ensure that the NixOS's HOMEDIR for this user is the same as home-manager's
            home.homeDirectory = config.users.users.${primaryUser}.home;

            age = {
              identityPaths = [ config.age.secrets.agenix-home-secret-key.path ];
              rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBE+2at1NN5ahYloIOYXyEhGi6lRN4PoapQz6CNoTo0r";
            };
          }
        ];

        extraSpecialArgs = {
          inherit (flakeArgs) inputs;
          inherit primaryUser;
          configName = "nixos_${hostName}";
          nhSwitchCommand = "nh os switch";
        };
      };

      age.secrets.agenix-home-secret-key = {
        rekeyFile = ./agenix-home-secret-key.age;
        owner = primaryUser;
      };
    };
}
