{

    nixpkgs.config.allowUnfree = true;

    nix = {
        extraOptions = ''
            experimental-features = nix-command flakes
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
