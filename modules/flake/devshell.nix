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

              echo "=> Deploying system '$hostname'"
              nh os switch . \
                  --hostname $hostname \
                  --target-host root@$hostname \
                  --build-host root@$hostname
            '';
          }
        ];
      };
    };
}
