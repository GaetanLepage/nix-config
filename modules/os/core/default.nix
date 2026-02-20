{
  flake.modules =
    let
      commonModule = {
        imports = [
          ./_nix.nix
        ];

        # Set your time zone.
        time.timeZone = "Europe/Paris";
      };
    in
    {
      nixos.core = commonModule;

      darwin.core = commonModule;
    };
}
