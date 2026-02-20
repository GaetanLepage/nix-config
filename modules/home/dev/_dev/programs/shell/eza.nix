{
  programs.eza = {
    enable = true;
    enableFishIntegration = false;
  };

  home.shellAliases = {
    ls = "eza";
    l = "eza -lhg";
    ll = "eza -alhg";
    lt = "eza --tree";
  };
}
