{ pkgs, ... }:

{
    imports = [
        ./exa.nix
    ];

    home = {
        packages = with pkgs; [
            direnv                      # Needed by lori
            spaceship-prompt
        ];

        shellAliases = import ./aliases.nix;
    };

    programs = {

        autojump.enable = true;

        direnv.enable = true;

        zsh = {
            enable = true;

            dotDir = ".config/zsh_nix";

            enableAutosuggestions = true;
            enableSyntaxHighlighting = true;

            history.size = 50000;

            oh-my-zsh = {
                enable = true;
                plugins = [ "git" ];
                custom = "$HOME/.config/zsh_nix/custom";
            };

            initExtra = ''
                # Spaceship theme
                source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
                autoload -U promptinit; promptinit

                source $HOME/.config/shell/shell_init
            '';
        };
    };
}
