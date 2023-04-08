{
  imports = [
    ../tui
    ../gui

    ./backup
    ./touchpad_toggle
  ];

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "gaetan";
    homeDirectory = "/home/gaetan";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.05";
  };

  # Load the pulseaudio module that enables sharing audio devices with computers on the network.
  programs.zsh.initExtra = ''
    if ! pactl list | grep -q "tcp"; then
        pactl load-module module-native-protocol-tcp > /dev/null
    fi
  '';
}
