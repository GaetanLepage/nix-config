{
  flake.modules.homeManager.keyring = {
    # Allows auto-unlocking of the gnome keyring at login
    services.gnome-keyring.enable = true;
    home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";
  };
}
