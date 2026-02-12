{
  flake.modules.nixos.nh = {
    programs.nh = {
      enable = true;

      clean = {
        enable = true;

        dates = "05:00";
        extraArgs = "--keep 5 --keep-since 8d";
      };
    };
  };
}
