{ pkgs, ... }:
{
    imports = [
        ./python.nix
        ./rust.nix
    ];

    home.packages = with pkgs; [
        nixpkgs-review

        hugo

        texlive.combined.scheme-full
    ];
}
