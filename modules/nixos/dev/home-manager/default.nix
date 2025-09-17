topLevel@{ inputs, ... }:
{
  flake.modules.nixos.home-manager =
    { config, ... }:
    let
      inherit (config.networking) hostName;
      userName = "gaetan";
    in
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.${userName}.imports = [
          topLevel.config.flake.modules.homeManager.core
          (topLevel.config.flake.modules.homeManager."host_${hostName}" or { })
          {
            age = {
              identityPaths = [ config.age.secrets.agenix-home-secret-key.path ];
              rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBE+2at1NN5ahYloIOYXyEhGi6lRN4PoapQz6CNoTo0r";
            };
          }
        ];

        extraSpecialArgs = {
          inputs = inputs;
          configName = "nixos_${hostName}";
        };
      };

      age.secrets.agenix-home-secret-key = {
        rekeyFile = ./agenix-home-secret-key.age;
        owner = userName;
      };
    };
}
