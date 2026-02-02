{
  flake.modules.homeManager.core = {
    programs.opencode = {
      enable = true;
    };

    home.shellAliases.oc = "opencode";
  };
}
