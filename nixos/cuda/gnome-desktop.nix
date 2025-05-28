{ pkgs, ... }:
{
  imports = [
    ./sound.nix
    ./gaming.nix
    ./xorg.nix
  ];

  services = {
    xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
        autoSuspend = false;
      };

      desktopManager.gnome.enable = true;

      serverFlagsSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
      '';

      # Configure keymap in X11
      xkb.layout = "fr";

      # Doesn't work + messed up when playing CS
      # xkbOptions = "caps:swapescape";

      # Whether to symlink the X server configuration under /etc/X11/xorg.conf
      exportConfiguration = true;
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Gnome extensions
    gnomeExtensions.dash-to-panel
    gnomeExtensions.vitals

    # GUI
    discord
    firefox
    mpv
    mumble
    signal-desktop
    spotify
    teamspeak_client
    thunderbird
  ];
}
