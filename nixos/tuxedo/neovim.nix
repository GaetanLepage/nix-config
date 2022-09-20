{ pkgs, ... }:

{

    # Use cachix communnity cache to fetch neovim binaries and avoid compiling it locally.
    nix.settings = {

        trusted-users = [ "root" "gaetan" ];

        substituters = [
            "https://nix-community.cachix.org"
        ];

        trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
    };

    environment.systemPackages = [ pkgs.neovim-nightly ];

    programs.neovim = {
        enable = true;

        package = pkgs.neovim-nightly;

        defaultEditor = true;

        viAlias = true;
        vimAlias = true;

        withNodeJs = true;
        withPython3 = true;
    };
}
