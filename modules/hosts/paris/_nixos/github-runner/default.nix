{ config, ... }:
{
  age.secrets.github-runner-token-file.rekeyFile = ./token-file.age;

  services.github-runners.main = {
    enable = true;
    url = "https://github.com/GaetanLepage/nix-config";

    tokenFile = config.age.secrets.github-runner-token-file.path;
  };
}
