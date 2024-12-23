{
  inputs,
  self,
  ...
}:
{
  flake.agenix-rekey = inputs.agenix-rekey.configure {
    userFlake = self;
    inherit (self) nixosConfigurations;
  };

  perSystem =
    {
      config,
      pkgs,
      system,
      ...
    }:
    {
      packages =
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ inputs.agenix-rekey.overlays.default ];
          };
        in
        {
          agenix = pkgs.agenix-rekey;
        };
    };
}
