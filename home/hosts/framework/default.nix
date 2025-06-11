{ pkgs, ... }:
{
  imports = [
    ../../modules/tui
    ../../modules/gui

    ./backup
    ./kanshi.nix
  ];

  # inria
  home.packages = with pkgs; [
    pdfsam-basic
    texlive.combined.scheme-full
    liberation-sans-narrow
  ];
}
