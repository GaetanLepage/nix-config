{
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';

    # Configure keymap in X11
    layout = "fr";

    xkbOptions = "caps:swapescape";

    # Whether to symlink the X server configuration under /etc/X11/xorg.conf
    exportConfiguration = true;
  };
}
