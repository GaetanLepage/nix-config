{
  flake.modules.nixos.desktop = {
    services = {
      gnome = {
        gnome-keyring.enable = true;

        # Already using home-manager's services.ssh-agent
        gcr-ssh-agent.enable = false;
      };
      udisks2.enable = true;

      # Default is "poweroff" which shutdowns the computer as soon as the power button is pressed.
      logind.settings.Login.HandlePowerKey = "lock";

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
