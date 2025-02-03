{ inputs, ... }:
{
  imports = [
    inputs.devshell.flakeModule
  ];

  perSystem =
    {
      config,
      pkgs,
      system,
      ...
    }:
    {
      devshells.default = {
        commands = [
          {
            name = "deploy";
            command = ''
              hostname=$1

              echo -e "\n=> Deploying system '$hostname'"
              nixos-rebuild switch \
                  --fast \
                  --flake .#$hostname \
                  --target-host root@$hostname \
                  --build-host root@$hostname
            '';
          }
        ];
      };
    };
}
