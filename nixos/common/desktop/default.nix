{ pkgs, ... }:
{
  imports = [
    ./thunar.nix
    ./wayland.nix
  ];

  services = {
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
