{pkgs, ...}: {
  imports = [
    ./python.nix
    ./rust.nix
    ./typst.nix
  ];

  home.packages = with pkgs; [
    nixpkgs-review
    alejandra
    statix

    texlive.combined.scheme-full
  ];
}
