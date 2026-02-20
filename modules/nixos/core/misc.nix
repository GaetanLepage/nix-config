{
  flake.modules.nixos.core = {
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
  };
}
