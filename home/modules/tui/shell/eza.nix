{pkgs, ...}: {
  programs.eza.enable = true;

  home.shellAliases = {
    ls = "${pkgs.eza}/bin/eza";
    l = "${pkgs.eza}/bin/eza -lFhg";
    ll = "${pkgs.eza}/bin/eza -alFhg";
  };
}
