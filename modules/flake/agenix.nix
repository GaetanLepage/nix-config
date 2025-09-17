{
  inputs,
  self,
  ...
}:
{
  flake.agenix-rekey = inputs.agenix-rekey.configure {
    userFlake = self;
    inherit (self) nixosConfigurations homeConfigurations;
  };

  perSystem =
    {
      inputs',
      ...
    }:
    {
      devshells.default = {
        packages = [
          inputs'.agenix-rekey.packages.default
        ];

        env = [
          # Automatically adds rekeyed secrets to git without
          # requiring `agenix rekey -a`.
          {
            name = "AGENIX_REKEY_ADD_TO_GIT";
            value = true;
          }
        ];
      };
    };
}
