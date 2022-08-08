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
    imports = [
        ./home
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

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
                # pandas
                pytorch
            ]))
        ];
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

    # Keyboard
    xsession.numlock.enable = true;
    home.keyboard = {
        layout = "fr";
        options = [ "caps:swapescape" ];
    };

}
