{ config, ... }:
{
  age.secrets = {
    github-runner-token-file.rekeyFile = ./token-file.age;
    github-runner-lk-token-file.rekeyFile = ./token-file-lk.age;
  };

  services.github-runners = {
    main = {
      enable = true;
      url = "https://github.com/GaetanLepage/nix-config";

      tokenFile = config.age.secrets.github-runner-token-file.path;
    };
    lk = {
      enable = true;
      url = "https://github.com/LepageKnives";

      tokenFile = config.age.secrets.github-runner-lk-token-file.path;
    };
  };
}
