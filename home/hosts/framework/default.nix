{ pkgs, ... }:
{
  imports = [
    ../../modules/tui
    ../../modules/gui

    ./backup
    ./update.nix
  ];

  # Allows auto-unlocking of the gnome keyring at login
  services.gnome-keyring.enable = true;
  home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";

  # Load the pulseaudio module that enables sharing audio devices with computers on the network.
  # inria
  programs.fish.interactiveShellInit = ''
    if ! pactl list | grep -q "tcp";
        pactl load-module module-native-protocol-tcp > /dev/null
    end
  '';

  # inria
  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];
}
