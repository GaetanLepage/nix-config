{
  flake.modules.homeManager.core =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        alejandra
        nix-tree
        nix-output-monitor
        statix
        patchelf

        # nixpkgs
        nix-update
        nixpkgs-review
        nixfmt
        nixfmt-tree
        luarocks-packages-updater
        vimPluginsUpdater
      ];
    };
}
