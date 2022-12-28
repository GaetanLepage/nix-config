{ pkgs, ... }:
{
    imports = [
        ./python.nix
        ./rust.nix
    ];

    home.packages = with pkgs; [
        nixpkgs-review
    ];
}
