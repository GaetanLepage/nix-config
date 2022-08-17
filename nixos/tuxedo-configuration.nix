# ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
# ██ ▄▄ █ ▄▄▀█ ▄▄█▄ ▄█ ▄▄▀█ ▄▄▀████ ████ ▄▄█▀▄▄▀█ ▄▄▀█ ▄▄▄█ ▄▄██
# ██ █▀▀█ ▀▀ █ ▄▄██ ██ ▀▀ █ ██ ████ ████ ▄▄█ ▀▀ █ ▀▀ █ █▄▀█ ▄▄██
# ██ ▀▀▄█▄██▄█▄▄▄██▄██▄██▄█▄██▄████ ▀▀ █▄▄▄█ ████▄██▄█▄▄▄▄█▄▄▄██
# ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
# website:  glepage.com
# github:   https://github.com/gaetanlepage
# email:    gaetan.lepage@inria.fr
#
# #-----------------------------------#
# | NixOS configuration for my laptop |
# #-----------------------------------#

{ config, pkgs, lib, ... }:

{
    imports = [
        # Include the results of the hardware scan.
        ./tuxedo-hw.nix

        ./modules/android.nix
        ./modules/bluetooth.nix
        ./modules/neovim.nix
        ./modules/packages.nix
        ./modules/sound.nix
        # ./modules/steam.nix
        ./modules/users.nix
        # ./modules/virtualbox.nix
        # ./modules/wacom.nix
        ./modules/wireguard.nix
        ./modules/x.nix
    ];


    nix = {
        package = pkgs.nixFlakes;
        extraOptions = ''
            experimental-features = nix-command flakes
        '';

        settings = {

            trusted-users = [ "root" "gaetan" ];

            substituters = [
                "https://nix-community.cachix.org"
            ];

            trusted-public-keys = [
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            ];

            # Automatically detect files in the store that have identical contents, and replaces
            # them with hard links to a single copy. This saves disk space.
            auto-optimise-store = true;
        };

        gc = {
            automatic = true;
            options = "--delete-older-than 2d";
        };
    };

    nixpkgs.config.allowUnfree = true;

    boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        loader = {
            systemd-boot = {
                enable = true;
                configurationLimit = 4;
            };

            efi.canTouchEfiVariables = true;

            timeout = 0;

            grub.enable = false;
        };
    };

    # Set your time zone.
    time.timeZone = "Europe/Paris";

    networking = {
        hostName = "tuxedo";

        networkmanager.enable = true;

        firewall.enable = true;
    };

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus13";
        keyMap = "fr";
    };

    fonts.fonts = with pkgs; [
        noto-fonts
        (nerdfonts.override {
            fonts = [
                "DejaVuSansMono"
                "Ubuntu"
            ];
        })
    ];

    services.gnome.gnome-keyring.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.pathsToLink = [ "/share/zsh" ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs = {
        dconf.enable = true;

        # https://github.com/NixOS/nixpkgs/issues/10349#issuecomment-341810990
        zsh.enable = true;
    };

    # Members of group wheel can execute sudo commands without password.
    security.sudo.wheelNeedsPassword = false;

    system = {
        autoUpgrade.enable = false;

        # This value determines the NixOS release from which the default
        # settings for stateful data, like file locations and database versions
        # on your system were taken. It‘s perfectly fine and recommended to leave
        # this value at the release version of the first install of this system.
        # Before changing this value read the documentation for this option
        # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
        stateVersion = "22.05"; # Did you read the comment?
    };
}
