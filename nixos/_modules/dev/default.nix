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
  options = {
    my-modules.dev = {
      enable = lib.mkEnableOption "";
    };
  };

  config = lib.mkIf cfg.enable {
    # Fish shell
    users.users.gaetan.shell = pkgs.fish;
    programs.fish.enable = true;
    environment.pathsToLink = [ "/share/fish" ];
  };
}
