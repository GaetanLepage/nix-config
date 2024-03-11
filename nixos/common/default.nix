{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./agenix.nix
    ./bootloader.nix
    ./fish.nix
    ./github-token
    ./nix.nix
    ./remote-builders
    ./security.nix
    ./ssh
    ./users.nix
  ];

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
