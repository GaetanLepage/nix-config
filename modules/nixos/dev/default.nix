flakeArgs: {
  flake.modules.nixos.dev =
    { config, primaryUser, ... }:
    {
      imports = with flakeArgs.config.flake.modules.nixos; [
        substituters
      ];

      # Enable nix-ld for easier uv use
      programs.nix-ld.enable = true;

      # Fish shell
      users.users.${primaryUser}.shell = config.programs.fish.package;
      programs.fish.enable = true;
      environment.pathsToLink = [ "/share/fish" ];
    };
}
