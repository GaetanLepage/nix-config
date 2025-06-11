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
            name = "update";
            command = ''
              echo "=> Updating flake inputs"
              nix flake update

              deploy

              git add flake.lock
              git commit -m "flake.lock: Update"
              git push
            '';
          }
          {
            name = "rebuild";
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
