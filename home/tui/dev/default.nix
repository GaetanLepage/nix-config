{pkgs, ...}: {
  imports = [
    ./nix.nix
    ./python.nix
    ./rust.nix
    ./typst.nix
  ];

  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];
}
