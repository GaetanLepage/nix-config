{pkgs, ...}: {
  imports = [
    ./python.nix
    ./rust.nix
    ./typst.nix
  ];

  home.packages = with pkgs; [
    nixpkgs-review
    alejandra

    hugo

    texlive.combined.scheme-full
  ];
}
