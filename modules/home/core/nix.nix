{
  flake.modules.homeManager.nix = {
    nix.settings = {
      warn-dirty = false;
      experimental-features = "nix-command flakes";

      max-jobs = "auto";
      use-xdg-base-directories = true;

      # Prevent garbage collection from altering nix-shells managed by nix-direnv
      # https://github.com/nix-community/nix-direnv#installation
      keep-outputs = true;
      keep-derivations = true;
    };
  };
}
