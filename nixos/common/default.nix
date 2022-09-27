{ pkgs, ... }:

{
    imports = [
        ./boot.nix
        ./nix.nix
        ./steam.nix
        ./users.nix
        ./x.nix
    ];

    environment.systemPackages = with pkgs; [
        git-crypt
    ];

    # Set your time zone.
    time.timeZone = "Europe/Paris";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        keyMap = "fr";
    };

    networking = {

        networkmanager.enable = true;
        firewall.enable = true;
    };
}
