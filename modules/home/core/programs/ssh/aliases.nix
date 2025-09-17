{
  flake.modules.homeManager.core = {
    home.shellAliases = {
      sb = "ssh builder";
      sba = "ssh builder -t zellij attach --create main";
    };
  };
}
