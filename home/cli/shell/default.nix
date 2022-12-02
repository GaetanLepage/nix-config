{
    imports = [
        ./exa.nix
        ./exputils.nix
        ./remi.nix
        ./zsh.nix
    ];

    home.shellAliases = import ./aliases.nix;

    programs = {
        atuin.enable = true;

        autojump.enable = true;

        direnv = {
            enable = true;
            nix-direnv.enable = true;
        };
    };
}
