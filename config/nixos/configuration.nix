# Edit this configuration file to define what should be installed on
# your system.    Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
            ./hardware-configuration.nix
        ];

    # Use the systemd-boot EFI boot loader.
    boot.loader = {
        # For UEFI
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;

        # For legacy BIOS
        # grub.device = "/dev/sda";
    };

    # Set your time zone.
    time.timeZone = "Europe/Paris";

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    networking = {
        hostName = "nixos";

        useDHCP = false;

        interfaces = {
            wlp58s0.useDHCP = true;
        };
        networkmanager.enable = true;

        # networking.wireless.enable = true;    # Enables wireless support via wpa_supplicant.
    };

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus13";
        keyMap = "fr";
    };

    fonts.fonts = with pkgs; [
        (nerdfonts.override { fonts = [ "Ubuntu" ]; })
    ];

    services = {
        xserver = {
            # Enable the X11 windowing system.
            enable = true;

            # Configure keymap in X11
            layout = "fr";

            # Enable touchpad support
            libinput.enable = true;

            displayManager = {
                lightdm.enable = true;
                # startx.enable = true;
            };

            windowManager.bspwm = {
                    enable = true;
            };
        };

        sshd = {
            enable = true;
        };
    };


    # services.xserver.xkbOptions = "eurosign:e";

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    # Enable sound.
    # sound.enable = true;
    # hardware.pulseaudio.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.gaetan = {
        isNormalUser = true;
        extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
        shell = pkgs.zsh;
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment = {
        variables = {
            EDITOR = "nvim";
        };
        systemPackages = with pkgs; [

            # Misc (system utilities)
            killall
            xorg.xkill
            vim
            wget
            ncdu
            tree

            # Network

            # Software development
            git
            neovim-nightly
            ctags

            # Shell
            zsh
            neofetch
            bat
            ranger
            fzf

            # Multimedia
            gthumb
            vlc
            mpv

            # Window manager
            picom
            bspwm
            sxhkd
            polybar
            dunst
            rofi
            xwallpaper

            # Hardware Monitoring
            bpytop
            htop
            # nvtop

            # GUI applications
            kitty
            firefox
            pcmanfm
            thunderbird
            zotero

            # Languages
            python3
        ];
    };

    nixpkgs = {
        config = {
            allowUnfree = true;
        };
        overlays = [
            (import (builtins.fetchTarball {
                url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
            }))
        ];
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #     enable = true;
    #     enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    system = {

        autoUpgrade = {
            enable = true;
            channel = "https://nixos.org/channels/nixos-unstable";
        };

    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "21.11"; # Did you read the comment?

}
