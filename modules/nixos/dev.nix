{
  flake.modules.nixos.dev =
    { config, primaryUser, ... }:
    {
      # Enable nix-ld for easier uv use
      programs.nix-ld.enable = true;

      # Fish shell
      environment.pathsToLink = [ "/share/fish" ];
    };
}
