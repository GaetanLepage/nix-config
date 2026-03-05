{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alejandra
    nix-tree
    nix-output-monitor
    nil
    statix
    patchelf

    # nixpkgs
    hydra-check
    nix-update
    nixpkgs-review
    nixfmt
    nixfmt-tree
    luarocks-packages-updater
    vimPluginsUpdater
  ];
}
