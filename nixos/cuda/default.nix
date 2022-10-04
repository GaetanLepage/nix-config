{
    config,
    pkgs,
    lib,
    ...
}:

{
    imports = [
        # Include the results of the hardware scan.
        ./hardware.nix

        ../common

        ./steam.nix
        ./ssh.nix
        ./nvidia.nix
        ./server-tank-nfs.nix
        ./wireguard.nix
    ];

    networking.hostName = "cuda";

    environment.systemPackages = with pkgs; [
        # Utils
        btop
        git
        git-crypt
        lazygit
        ncdu
        unzip

        gnomeExtensions.dash-to-dock

        # GUI
        discord
        firefox
        mpv
        signal-desktop
        spotify
        teamspeak_client
        thunderbird
    ];

    programs = {
        neovim = {
            enable = true;

            defaultEditor = true;

            viAlias = true;
            vimAlias = true;
        };
	singularity.enable = true;
    };

    services.xserver = {
        displayManager.gdm = {
	    enable = true;
	    autoSuspend = false;
	};

        desktopManager.gnome.enable = true;
    };

    system = {
        autoUpgrade = {
            enable = true;
            flake = "${config.users.users.gaetan.home}/config#cuda";
            flags = [
                "--update-input" "nixpkgs"
                "--commit-lock-file"
            ];
        };

        # This value determines the NixOS release from which the default
        # settings for stateful data, like file locations and database versions
        # on your system were taken. It‘s perfectly fine and recommended to leave
        # this value at the release version of the first install of this system.
        # Before changing this value read the documentation for this option
        # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
        stateVersion = "22.05"; # Did you read the comment?
    };
}
