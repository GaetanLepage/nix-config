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

        ./nvidia.nix
        ./wireguard.nix
    ];

    networking.hostName = "cuda";

    environment.systemPackages = with pkgs; [
        # Utils

        # GUI
        discord
        firefox
        signal-desktop
    ];

    programs = {
        neovim = {
            enable = true;

            defaultEditor = true;

            viAlias = true;
            vimAlias = true;
        };
    };

    services.xserver = {
        displayManager.sddm.enable = true;
        desktopManager.plasma5.enable = true;
    };

    system = {
        autoUpgrade = {
            enable = true;
            flake = "${config.users.users.gaetan.home}/dotfiles#cuda";
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
