flakeArgs: {
  flake.modules.nixos.dev = {
    imports = [
      flakeArgs.config.flake.modules.nixos.home-manager
    ];
  };

  flake.modules.darwin.dev = {
    imports = [
      flakeArgs.config.flake.modules.darwin.home-manager
    ];
  };
}
