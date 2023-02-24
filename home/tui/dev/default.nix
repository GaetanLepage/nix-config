{pkgs, ...}: {
  imports = [
    ./python.nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    nixpkgs-review
    alejandra

    hugo

    texlive.combined.scheme-full
  ];
}
