{
    imports = [
        ./boot.nix
        ./nix.nix
        ./users.nix
    ];

    # Set your time zone.
    time.timeZone = "Europe/Paris";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus13";
        keyMap = "fr";
    };

    # Members of group wheel can execute sudo commands without password.
    security.sudo.wheelNeedsPassword = false;

    networking = {

        networkmanager.enable = true;
        firewall.enable = true;
    };
}
