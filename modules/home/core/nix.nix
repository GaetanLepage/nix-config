{
  flake.modules.homeManager.nix = {
    nix.settings = {
      warn-dirty = false;
      experimental-features = "nix-command flakes";
    };
  };
}
