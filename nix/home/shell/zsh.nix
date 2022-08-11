{ config, pkgs, ... }:


{
    xdg.configFile.zsh_vim_bindings = {
        source = ./zsh_vim_bindings;
        target = "zsh/zsh_vim_bindings";
    };

    home.packages = [ pkgs.pfetch ];

    programs.zsh = {
        enable = true;

        dotDir = ".config/zsh";

        enableAutosuggestions = true;
        enableSyntaxHighlighting = true;

        history.size = 50000;

        oh-my-zsh = {
            enable = true;
            plugins = [ "git" ];
            # custom = "$HOME/.config/zsh_nix/custom"; TODO remove ?
        };

        initExtra = ''
            # Spaceship theme
            source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
            autoload -U promptinit; promptinit

            pfetch

            # Vim keybindings
            source ${config.xdg.configFile.zsh_vim_bindings.target}
        '';
    };
}
