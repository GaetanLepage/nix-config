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

        # ./modules/wacom.nix
        # ./modules/virtualbox.nix
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
    };


    boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        loader = {
            systemd-boot.enable = false;
            efi.canTouchEfiVariables = true;

            timeout = 0;

            grub = {
                enable = true;
                device = "nodev";
                efiSupport = true;

                # Limits the number of configurations to keep.
                # This prevents wasting to much space but more importantly, prevents the /boot
                # partition from getting full.
                configurationLimit = 4;

                # For legacy BIOS
                # device = "/dev/sda";
            };
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

        # wireguard.interfaces = {
        wg-quick.interfaces.wg0 = {
            # Determines the IP address and subnet of the client's end of the tunnel interface.
            # ips = [ "10.10.10.8/32" ];
            address = [ "10.10.10.2/32" ];
            listenPort = 51820;
            dns = [ "10.10.10.1" ];

            # Path to the private key file.
            #
            # Note: The private key can also be included inline via the privateKey option,
            # but this makes the private key world-readable; thus, using privateKeyFile is
            # recommended.
            privateKeyFile = "/home/gaetan/.dotfiles/secrets/wireguard/tuxedo_privatekey";

            peers = [
                # For a client configuration, one peer entry for the server will suffice.
                {
                    # Public key of the server (not a file path).
                    publicKey = "jWzlVwkNkaO1uj7Qh+Xemo0EtxIYP2ufK+18oPcdvBY=";

                    # Forward all the traffic via VPN.
                    allowedIPs = [ "0.0.0.0/0" ];
                    # Or forward only particular subnets
                    # allowedIPs = [ "10.10.10.0/24" ];

                    # Set this to the server IP and port.
                    endpoint = "109.13.20.45:51820";

                    # Send keepalives every 25 seconds. Important to keep NAT tables alive.
                    persistentKeepalive = 25;
                }
            ];
        };


        firewall = {
            enable = true;

            # Open ports in the firewall.
            allowedTCPPorts = [ 22 ];
            allowedUDPPorts = [ ];
        };
    };

    systemd.services = {
        wg-quick-wg0.wantedBy = lib.mkForce [ ];
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
        hashedPassword = "$6$vSEllGq22uUqcTqr$yfnc8NR4oojOWKt20IPT9jG3QvXoYu4h1fOkOAZi76bK7dV/BliVjuIySO3zJfZF/zYV4h51VuhknRVroe10t0";
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
            acpilight                   # Screen brightness control
            arandr
            autorandr
            cachix
            home-manager                # A user environment configurator
            killall
            libnotify                   # Provides the `notify-send` command
            networkmanagerapplet
            nfs-utils
            nix-index
            pavucontrol
            pulseaudio                  # Even though using Pipewire, pulseaudio provides `pactl`
            playerctl
            vim
            udiskie
            xclip
            xorg.xbacklight
            xorg.xev
            xorg.xkill
            xorg.xmodmap

            # Network
            dig                         # Domain name server
            lsof
            speedtest-cli
            wol                         # Wake on Lan

            # Software development
            ctags
            git
            lazygit
            neovim-nightly
            swig
            texlive.combined.scheme-full

            # Shell
            bash
            zsh
            pfetch

            # CLI utilities
            bat
            exa
            fzf
            file
            ncdu
            poppler_utils               # A PDF rendering library (used by `ranger` to preview PDFs)
            ranger
            ripgrep
            tmux
            tree
            unzip
            wget

            # Multimedia
            ffmpeg
            ffmpegthumbnailer
            gthumb
            imagemagick
            mpv
            vlc

            # Window manager
            betterlockscreen
            bspwm
            dunst
            mons
            picom
            polybar
            rofi
            sxhkd
            xwallpaper

            # Hardware Monitoring
            btop
            htop

            # GUI applications
            discord
            kitty
            firefox
            flameshot
            element-desktop
            jitsi-meet-electron
            libreoffice-fresh
            mumble
            nextcloud-client
            okular
            pcmanfm
            pdfsam-basic
            rstudio                     # TODO remove when PMS is over
            signal-desktop
            spotify
            tdesktop                    # Telegram desktop
            thunderbird
            zathura
            zotero

            # Languages
            clang
            gcc
            python39
        ];

        pathsToLink = [ "/share/zsh" ];
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
        stateVersion = "21.11"; # Did you read the comment?
    };

    security = {
        # Members of group wheel can execute sudo commands without password.
        sudo.wheelNeedsPassword = false;

        pam.services.sddm.enableGnomeKeyring = true;
    };
}
