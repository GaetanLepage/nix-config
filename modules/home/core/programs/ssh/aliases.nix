{
  flake.modules.homeManager.core = {
    home.shellAliases = {
      sb = "ssh builder";
      sba = "ssh builder -t zellij attach --create main";
      sc = "ssh cuda";
      sca = "ssh cuda -t zellij attach --create main";
      sj = "ssh jrs";
      sp = "ssh paris";
      spa = "ssh paris -t zellij attach --create main";
    };
  };
}
