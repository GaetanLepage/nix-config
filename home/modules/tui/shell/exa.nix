{
  pkgs,
  lib,
  ...
}: {
  programs.exa.enable = true;

  home.shellAliases = {
    ls = "${pkgs.exa}/bin/exa";
    l = "${pkgs.exa}/bin/exa -lFhg";
    ll = "${pkgs.exa}/bin/exa -alFhg";
  };
}
