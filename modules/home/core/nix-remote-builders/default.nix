{
  flake.modules.homeManager.core = {
    imports = [
      ./_ssh
    ];

    nix = {
      distributedBuilds = true;

      settings.builders-use-substitutes = true;
    };
  };
}
