{

    nixpkgs.config.allowUnfree = true;

    nix = {
        extraOptions = ''
            experimental-features = nix-command flakes

            # Prevent garbage collection from altering nix-shells managed by nix-direnv
            # https://github.com/nix-community/nix-direnv#installation
            keep-outputs = true
            keep-derivations = true
        '';

        settings = {
            # Automatically detect files in the store that have identical contents, and replaces
            # them with hard links to a single copy. This saves disk space.
            auto-optimise-store = true;
        };

        gc = {
            automatic = true;
            options = "--delete-older-than 2d";
        };
    };
}
