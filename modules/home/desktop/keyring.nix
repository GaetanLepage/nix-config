{
  flake.modules.homeManager.keyring = {
    # Allows auto-unlocking of the gnome keyring at login
    services.gnome-keyring.enable = true;
  };
}
