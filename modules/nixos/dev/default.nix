flakeArgs: {
  flake.modules.nixos.dev =
    { config, ... }:
    {
      imports = with flakeArgs.config.flake.modules.nixos; [
        home-manager
        substituters
      ];

      # Enable nix-ld for easier uv use
      programs.nix-ld.enable = true;

      # Fish shell
      users.users.gaetan.shell = config.programs.fish.package;
      programs.fish.enable = true;
      environment.pathsToLink = [ "/share/fish" ];
    };
}
