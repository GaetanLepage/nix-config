{ pkgs, ... }:

{
    imports = [
        ./exa.nix
        ./exputils.nix
        ./zsh.nix
    ];

    home = {
        packages = with pkgs; [
            direnv                      # Needed by lori
        ];

        shellAliases = import ./aliases.nix;
    };

    programs = {
        autojump.enable = true;
        direnv.enable = true;
        fzf.enable = true;
    };
}
