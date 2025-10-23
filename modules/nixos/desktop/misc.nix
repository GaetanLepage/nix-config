{
  flake.modules.nixos.desktop = {
    services = {
      gnome = {
        gnome-keyring.enable = true;

        # programs.ssh.startAgent is already providing an SSH agent
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
