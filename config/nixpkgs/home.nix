{ config, pkgs, ... }:

{
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home = {
        username = "gaetan";
        homeDirectory = "/home/gaetan";

        # This value determines the Home Manager release that your
        # configuration is compatible with. This helps avoid breakage
        # when a new Home Manager release introduces backwards
        # incompatible changes.
        #
        # You can update Home Manager without changing this value. See
        # the Home Manager release notes for a list of state version
        # changes in each release.
        stateVersion = "22.05";

        packages = with pkgs; [
            direnv
            autojump
        ];
    };

    programs = {
        # Let Home Manager install and manage itself.
        home-manager.enable = true;

        zsh = {
            enable = true;

            dotDir = ".config/zsh_nix";

            initExtra = ''
                source $HOME/.config/shell/shell_init
            '';

            enableAutosuggestions = true;
            enableSyntaxHighlighting = true;

            oh-my-zsh = {
                enable = true;
                plugins = [ "git" "autojump" ];
                custom = "$HOME/.config/zsh_nix/custom";
                theme = "spaceship";
            };
        };
    };

    services = {
        betterlockscreen = {
            enable = true;
        };
    };

    nixpkgs.config.allowUnfree = true;

    xsession.pointerCursor = {
        name = "Dark";
        package = pkgs.capitaine-cursors;
    };

    gtk = {
        enable = true;
        theme = {
            name = "Matcha-dark-aliz";
            package = pkgs.matcha-gtk-theme;
        };
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };
        font = {
            name = "DejaVu Sans 11";
        };
    };
}
