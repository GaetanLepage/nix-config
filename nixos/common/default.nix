{
  imports = [
    ./bootloader.nix
    ./fish.nix
    ./nix.nix
    # ./remote-builders.nix
    ./security.nix
    ./ssh.nix
    ./users.nix
  ];

  age.rekey.masterIdentities = [../../identity.age];

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  # LVS (fwupd)
  services.fwupd.enable = true;

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };
}
