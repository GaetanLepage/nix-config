{ config, pkgs, ... }:
let
  backup-script = pkgs.writeShellApplication {
    name = "backup-to-hdd";

    runtimeInputs = with pkgs; [
      cryptsetup
      msmtp
    ];

    runtimeEnv = {
      EMAIL_PASSWORD_PATH = config.age.secrets.backup-mail-password.path;
      LUKS_PASSWORD_PATH = config.age.secrets.luks-password.path;
    };

    text = builtins.readFile ./backup-to-hdd.sh;
  };
in
{
  age.secrets = {
    backup-mail-password.rekeyFile = ./backup-mail-password.age;
    luks-password.rekeyFile = ./luks-password.age;
  };

  environment.systemPackages = [
    backup-script
    pkgs.cryptsetup
  ];
}
