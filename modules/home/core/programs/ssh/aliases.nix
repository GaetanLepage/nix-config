{
  flake.modules.homeManager.core = {
    home.shellAliases = {
      s = "ssh";
      sa = "ssh alya"; # inria
      sc = "ssh cuda";
      sca = "ssh cuda -t zellij attach --create main";
      sj = "ssh jrs";
    };
  };
}
