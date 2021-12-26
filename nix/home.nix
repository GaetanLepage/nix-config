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
            # Shell
            direnv                      # Needed by lori

            # Software development
            conda

            # Misc
            git-crypt

            # Python
            python39Packages.pip
            (python39.withPackages(ps: with ps; [
                # Misc
                dbus-python             # Needed by the polybar spotify script
                numpy

                # Neovim
                pynvim                  # Python support for neovim

                ## Linters
                flake8
                mypy
                pylint

                ## Python Language Server
                pyls-flake8             # Flake8 plugin for pylsp
                python-lsp-server       # Python language server
                pylsp-mypy              # mypy plugin for pylsp
            ]))

            # neovim
            nodePackages.neovim
            nodejs
            tree-sitter

            # Language servers
            nodePackages.bash-language-server           # Bash language server
            nodePackages.typescript                     # TypeScript
            nodePackages.typescript-language-server     # TypeScript language server
            sumneko-lua-language-server                 # Lua language server
            clang-tools                                 # C/C++ language server
            texlab                                      # LaTeX language server
            xdotool                                     # For forward search in zathura
            pstree                                      # For inverse search in vimtex
            rnix-lsp                                    # Nix language server
        ];
    };

    programs = {
        # Let Home Manager install and manage itself.
        home-manager.enable = true;

        autojump.enable = true;

        firefox = {
            enable = true;

            profiles.gaetan = {
                isDefault = true;
                path = "gaetan";
                userChrome = ''
                    #TabsToolbar {
                        visibility: collapse !important;
                    }
                '';
            };
        };

        zsh = {
            enable = true;

            dotDir = ".config/zsh_nix";

            initExtra = ''
                source $HOME/.config/shell/shell_init

                # Hook direnv
                emulate zsh -c "$(direnv hook zsh)"
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
        gnome-keyring.enable = true;

        gpg-agent = {
            enable = true;
            enableSshSupport = true;
        };

        blueman-applet.enable = true;
        network-manager-applet.enable = true;
        lorri.enable = true;
    };

    nixpkgs.config.allowUnfree = true;

    xsession = {
        numlock.enable = true;

        pointerCursor = {
            name = "Numix-Cursor-Light";
            package = pkgs.numix-cursor-theme;
        };
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
