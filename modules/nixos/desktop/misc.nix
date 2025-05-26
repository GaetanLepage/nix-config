{
  flake.modules.nixos.desktop = {
    services = {
      gnome.gnome-keyring.enable = true;
      udisks2.enable = true;

      # Keyboard led config
      g810-led = {
        enable = true;
        profile = ''
          a ff      # Set all keys on
          c         # Commit changes
        '';
      };
    };
  };
}
