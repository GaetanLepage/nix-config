{
    imports = [
        ./boot.nix
        ./nix.nix
        ./steam.nix
        ./users.nix
        ./x.nix
    ];

    # Set your time zone.
    time.timeZone = "Europe/Paris";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus13";
        keyMap = "fr";
    };

    networking = {

        networkmanager.enable = true;
        firewall.enable = true;
    };
}
