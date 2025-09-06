topLevel: {
  flake.modules.nixos.dev =
    { config, ... }:
    {
      imports = with topLevel.config.flake.modules.nixos; [
        home-manager
        remote-builders
        ssh-client
        substituters
      ];

      # GitHub token
      age.secrets.github-token = {
        rekeyFile = ./github-token.age;
        owner = "gaetan";
      };

      # Enable nix-ld for easier uv use
      programs.nix-ld.enable = true;

      # Fish shell
      users.users.gaetan.shell = config.programs.fish.package;
      programs.fish.enable = true;
      environment.pathsToLink = [ "/share/fish" ];
    };
}
