{
  config,
  pkgs,
  ...
}: let
  runnerName = "gaetan-cuda";
in {
  age.secrets.github-runner-nixvim-token.file = ../../secrets/github-runner-nixvim-token.age;

  nix.settings.trusted-users = [
    "github-runner-${runnerName}"
  ];

  services.github-runner = {
    enable = true;

    name = runnerName;
    url = "https://github.com/nix-community/nixvim";
    tokenFile = config.age.secrets.github-runner-nixvim-token.path;

    extraPackages = with pkgs; [
      cachix
    ];
  };
}
