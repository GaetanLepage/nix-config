{
    nixpkgs.config.allowUnfree = true;

    nix = {

        settings = {
            experimental-features = "nix-command flakes";

            # Prevent garbage collection from altering nix-shells managed by nix-direnv
            # https://github.com/nix-community/nix-direnv#installation
            keep-outputs = true;
            keep-derivations = true;

            # Automatically detect files in the store that have identical contents, and replaces
            # them with hard links to a single copy. This saves disk space.
            auto-optimise-store = true;

            warn-dirty = false;
        };

        gc = {
            automatic = true;
            options = "--delete-older-than 2d";
        };

        # set the value NIX_PATH to whatever nixpkgs our flake uses
        # nixPath = [ "nixpkgs=/etc/nix/inputs/nixpkgs" ];
    };

}
