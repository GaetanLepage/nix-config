{
  flake.modules.homeManager.core = {
    programs.nix-init = {
      enable = true;
      settings = {
        maintainers = [ "GaetanLepage" ];
      };
    };
  };
}
