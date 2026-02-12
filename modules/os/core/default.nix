{
  flake.modules =
    let
      commonModule = {
        imports = [
          ./_nix.nix
        ];
      };
    in
    {
      nixos.core = commonModule;

      darwin.core = commonModule;
    };
}
