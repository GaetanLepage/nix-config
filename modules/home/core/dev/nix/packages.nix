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
        nixfmt-rfc-style
        luarocks-packages-updater
        vimPluginsUpdater
      ];
    };
}
