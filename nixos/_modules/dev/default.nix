{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my-modules.dev;
in
{
  imports = [
    ./ssh-client
    ./remote-builders
  ];

  options = {
    my-modules.dev = {
      enable = lib.mkEnableOption "";
    };
  };

  config = lib.mkIf cfg.enable {
    my-modules.dev = {
      remoteBuilders.enable = true;
      sshClient.enable = true;
    };

    # Fish shell
    users.users.gaetan.shell = pkgs.fish;
    programs.fish.enable = true;
    environment.pathsToLink = [ "/share/fish" ];
  };
}
