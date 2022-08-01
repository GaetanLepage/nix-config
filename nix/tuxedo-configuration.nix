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
        # ./modules/steam.nix
        # ./modules/virtualbox.nix
        # ./modules/wacom.nix
        ./modules/wireguard.nix
    ];


    nix = {
        package = pkgs.nixFlakes;
        extraOptions = ''
            experimental-features = nix-command flakes
        '';

        trustedUsers = [ "root" "gaetan" ];

        binaryCaches = [
            "https://nix-community.cachix.org"
        ];

        binaryCachePublicKeys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

        gc = {
            automatic = true;
            options = "--delete-older-than 2d";
        };
    };


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
            # grub = {
            #     enable = true;
            #     device = "nodev";
            #     efiSupport = true;
            #
            #     # Limits the number of configurations to keep.
            #     # This prevents wasting to much space but more importantly, prevents the /boot
            #     # partition from getting full.
            #     configurationLimit = 4;
            #
            #     enableCryptodisk = true;
            #
            #     # For legacy BIOS
            #     # device = "/dev/sda";
            # };
        };
    };

    # Set your time zone.
    time.timeZone = "Europe/Paris";

    networking = {
        hostName = "tuxedo";

        # The global useDHCP flag is deprecated, therefore explicitly set to false here.
        # Per-interface useDHCP will be mandatory in the future, so this generated config
        # replicates the default behaviour.
        useDHCP = false;

        networkmanager.enable = true;

        firewall = {
            enable = true;

            # Open ports in the firewall.
            allowedTCPPorts = [ 22 ];
            allowedUDPPorts = [ ];
        };
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

    # List services that you want to enable:
    services = {

        gnome.gnome-keyring.enable = true;

        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
        };

        logind.extraConfig = ''
            # don’t shutdown when power button is short-pressed
            HandlePowerKey=ignore
        '';

        xserver = {
            # Enable the X11 windowing system.
            enable = true;

            serverFlagsSection = ''
              Option "BlankTime" "0"
              Option "StandbyTime" "0"
              Option "SuspendTime" "0"
              Option "OffTime" "0"
            '';

            # Configure keymap in X11
            layout = "fr";

            # Enable touchpad support
            libinput.enable = true;

            # Whether to symlink the X server configuration under /etc/X11/xorg.conf
            exportConfiguration = true;

            displayManager = {
                # startx.enable = true;
                lightdm = {
                    enable = true;

                    greeters = {
                        gtk = {
                            enable = true;
                            theme = {
                                name = "Matcha-dark-aliz";
                                package = pkgs.matcha-gtk-theme;
                            };
                            cursorTheme = {
                                name = "Numix-Cursor-Light";
                                package = pkgs.numix-cursor-theme;
                            };
                        };
                    };
                };
            };

            windowManager.bspwm.enable = true;
        };

        openssh = {
            enable = true;
            passwordAuthentication = false;
        };

        blueman.enable = true;
    };


    # Enable sound. Set to `false` if using PipeWire
    sound.enable = false;

    hardware = {
        pulseaudio.enable = false;

        # Bluetooth
        bluetooth = {
            enable = true;
            powerOnBoot = true;
        };
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.gaetan = {
        isNormalUser = true;
        extraGroups = [
            "wheel"             # Enable ‘sudo’ for the user.
            "networkmanager"    # Enable user to add and edit network connections
        ];
        initialPassword = "password";
        shell = pkgs.zsh;
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment = {
        variables = {
            EDITOR = "nvim";
        };

        pathsToLink = [ "/share/zsh" ];

        systemPackages = import ./modules/packages.nix pkgs;
    };

    nixpkgs = {
        config = {
            allowUnfree = true;

            pulseaudio = true;
        };
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs = {
        dconf.enable = true;

        # https://github.com/NixOS/nixpkgs/issues/10349#issuecomment-341810990
        zsh.enable = true;
    };

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

    security = {
        # Members of group wheel can execute sudo commands without password.
        sudo.wheelNeedsPassword = false;

        pam.services.sddm.enableGnomeKeyring = true;
    };
}
