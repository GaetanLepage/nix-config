{inputs, ...}: {
  imports = [
    inputs.devshell.flakeModule
  ];

  perSystem = {
    config,
    pkgs,
    system,
    ...
  }: {
    devshells.default = {
      packages = [
        inputs.agenix-rekey.packages.${system}.default
      ];

      commands = [
        {
          name = "deploy";
          command = ''
            hostname=$1

            echo "=> Deploying system '$hostname'"
            nixos-rebuild switch \
                --fast \
                --flake .#$hostname \
                --target-host root@$hostname \
                --build-host root@$hostname
          '';
        }
        {
          name = "update";
          command = ''
            echo "=> Updating flake inputs"
            nix flake update

            deploy cuda
            deploy chamaeleon
          '';
        }
      ];
    };
  };
}
