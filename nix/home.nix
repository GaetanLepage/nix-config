# ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
# ██ ▄▄ █ ▄▄▀█ ▄▄█▄ ▄█ ▄▄▀█ ▄▄▀████ ████ ▄▄█▀▄▄▀█ ▄▄▀█ ▄▄▄█ ▄▄██
# ██ █▀▀█ ▀▀ █ ▄▄██ ██ ▀▀ █ ██ ████ ████ ▄▄█ ▀▀ █ ▀▀ █ █▄▀█ ▄▄██
# ██ ▀▀▄█▄██▄█▄▄▄██▄██▄██▄█▄██▄████ ▀▀ █▄▄▄█ ████▄██▄█▄▄▄▄█▄▄▄██
# ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
# website:  glepage.com
# github:   https://github.com/gaetanlepage
# email:    gaetan.lepage@inria.fr
#
# #----------------------------#
# | Home-manager configuration |
# #----------------------------#

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

        pointerCursor = {
            name = "Numix-Cursor-Light";
            package = pkgs.numix-cursor-theme;
        };

        packages = with pkgs; [
            # Shell
            direnv                      # Needed by lori
            spaceship-prompt

            # Misc
            git-crypt
            hugo
            pandoc

            # Python
            (python3.withPackages(ps: with ps; [
                # Misc
                pip
                setuptools
                dbus-python             # Needed by the polybar spotify script

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

                # RL
                gym
                ipython
                matplotlib
                numpy
                pandas
                pytorch
            ]))

            # neovim
            nodePackages.neovim
            nodejs
            tree-sitter
            yarn                        # Needed to install Markdown-preview plugin

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

            profiles = {
                gaetan = {
                    id = 0;
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

                lcf = {
                    id = 1;
                    isDefault = false;
                    path = "lcf";
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
        };

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

    services = {
        # gnome-keyring.enable = true;

        # gpg-agent = {
        #     enable = true;
        #     enableSshSupport = true;
        # };

        blueman-applet.enable = true;
        network-manager-applet.enable = true;
        lorri.enable = true;
    };

    nixpkgs.config.allowUnfree = true;

    xsession.numlock.enable = true;

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

    xdg = {
        enable = true;

        userDirs = {
            enable = true;

            desktop     = "$HOME/desktop";
            documents   = "$HOME/documents";
            download    = "$HOME/downloads";
            music       = "$HOME/music";
            pictures    = "$HOME/pictures";
            publicShare = "$HOME/public";
            templates   = "$HOME/templates";
            videos      = "$HOME/videos";

        };

        mimeApps = {
            enable = true;

            defaultApplications = {
                # Applications
                "application/pdf"   = "org.pwmt.zathura.desktop";

                # Text
                "text/html"         = "firefox.desktop";
                "text/xml"          = "firefox.desktop";

                # Images
                "image/gif"         = "mpvgif.desktop";
                "image/heif"        = "org.gnome.gThumb.desktop";
                "image/jpeg"        = "org.gnome.gThumb.desktop";
                "image/png"         = "org.gnome.gThumb.desktop";

                # Videos
                "video/mp4"         = "vlc.desktop";    # .mp4
                "video/quicktime"   = "vlc.desktop";    # .mov
                "video/x-matroska"  = "vlc.desktop";    # .mkv
                "video/x-ms-wmv"    = "vlc.desktop";    # .wmv
            };
        };
    };

    xresources = {

    };
}
