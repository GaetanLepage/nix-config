{ pkgs, ... }:
{
  imports = [
    ./printing.nix
    ./thunar.nix
    ./wayland.nix
  ];

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

  environment.systemPackages = with pkgs; [
    discord

    # Multimedia
    ffmpeg
    ffmpegthumbnailer
    gthumb
    imagemagick
    mpv
    vlc
  ];
}
