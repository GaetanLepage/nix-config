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

        keyboard = {
            layout = "fr";
            options = [ "caps:swapescape" ];
        };

        packages = with pkgs; [
            # Shell
            direnv                      # Needed by lori
            spaceship-prompt

            # Software development
            conda

            # Misc
            git-crypt

            # Email
            libsecret

            # Python
            (python39.withPackages(ps: with ps; [
                # Misc
                pip
                setuptools
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
                settings = {
                    # Needed to hide the tab bar
                    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                };

                # Hide the tab bar
                userChrome = ''
                    #TabsToolbar { visibility: collapse !important; }
                '';
            };
        };

        neomutt.enable = true;

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

                # Hook direnv
                emulate zsh -c "$(direnv hook zsh)"
            '';
        };
    };

    accounts.email.accounts = {
        glepage = {
            address = "gaetan@glepage.com";
            userName = "gaetan@glepage.com";
            realName = "Gaétan Lepage";

            imap = {
                host = "glepage.com";
                port = 993;
                tls.enable = true;
            };

            smtp = {
                host = "glepage.com";
                port = 587;
                tls = {
                    enable = true;
                    useStartTls = true;
                };
            };
            neomutt.enable = true;
            passwordCommand = "mail-password";
            mbsync = {
                enable = true;
                create = "maildir";
            };
        };
        hotmail = {
            address = "gaetlep@hotmail.fr";
            userName = "gaetlep@hotmail.fr";
            realName = "Gaétan Lepage";

            imap = {
                host = "outlook.office365.com";
                port = 993;
                tls.enable = true;
            };

            smtp = {
                host = "smtp.office365.com";
                port = 587;
                tls = {
                    enable = true;
                    useStartTls = true;
                };
            };
            neomutt.enable = true;
            passwordCommand = "mail-password";
        };
        ensimag-fr = {
            address = "gaetan.lepage@grenoble-inp.fr";
            userName = "gaetan.lepage@grenoble-inp.fr";
            realName = "Gaétan Lepage";

            imap = {
                host = "imap.grenoble-inp.fr";
                port = 993;
                tls.enable = true;
            };

            smtp = {
                host = "smtp.grenoble-inp.fr";
                port = 587;
                tls = {
                    enable = true;
                    useStartTls = true;
                };
            };
            neomutt.enable = true;
            passwordCommand = "mail-password";
        };
        ensimag-org = {
            address = "gaetan.lepage@grenoble-inp.org";
            userName = "gaetan.lepage@grenoble-inp.org";
            realName = "Gaétan Lepage";

            imap = {
                host = "imap.partage.renater.fr";
                port = 993;
                tls.enable = true;
            };

            smtp = {
                host = "smtp.partage.renater.fr";
                port = 465;
                tls.enable = true;
            };
            neomutt.enable = true;
            passwordCommand = "mail-password";
        };
        inria = {
            primary = true;

            address = "gaetan.lepage@inria.fr";
            userName = "galepage";
            realName = "Gaétan Lepage";

            imap = {
                host = "zimbra.inria.fr";
                port = 993;
                tls.enable = true;
            };

            smtp = {
                host = "smtp.inria.fr";
                port = 587;
                tls = {
                    enable = true;
                    useStartTls = true;
                };
            };
            passwordCommand = "mail-password";
            neomutt.enable = true;
            mbsync = {
                enable = true;
                create = "maildir";
            };
        };
        gmx = {
            address = "g.lepage@gmx.com";
            userName = "g.lepage@gmx.com";
            realName = "Gaétan Lepage";

            imap = {
                host = "imap.gmx.com";
                port = 993;
                tls.enable = true;
            };

            smtp = {
                host = "mail.gmx.com";
                port = 465;
                tls.enable = true;
            };
            neomutt.enable = true;
            passwordCommand = "mail-password";
        };
        lepage-knives = {
            address = "glepage@lepage-knives.com";
            userName = "glepage@lepage-knives.com";
            realName = "Gaétan Lepage";

            imap = {
                host = "imap.ionos.fr";
                port = 143;
                tls = {
                    enable = true;
                    useStartTls = true;
                };
            };

            smtp = {
                host = "smtp.ionos.fr";
                port = 465;
                tls.enable = true;
            };
            neomutt.enable = true;
            passwordCommand = "mail-password";
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
