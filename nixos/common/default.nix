{
  imports = [
    ./bootloader.nix
    ./fish.nix
    ./github-token
    ./nix.nix
    ./remote-builders
    ./security.nix
    ./ssh
    ./users.nix
  ];

  age.rekey = {
    storageMode = "local";
    masterIdentities = [../../.secrets/identity.age];
  };

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
