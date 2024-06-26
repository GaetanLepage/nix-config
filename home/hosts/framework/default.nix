{
  imports = [
    ../../modules/tui
    ../../modules/gui

    ./backup
    ./update.nix
  ];

  # Load the pulseaudio module that enables sharing audio devices with computers on the network.
  programs.fish.interactiveShellInit = ''
    if ! pactl list | grep -q "tcp";
        pactl load-module module-native-protocol-tcp > /dev/null
    end
  '';
}
