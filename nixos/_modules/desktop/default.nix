{ pkgs, ... }:
{
  imports = [
    ./obs.nix
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

  # Needed by the nheko matrix client
  nixpkgs.config.permittedInsecurePackages = [ "olm-3.2.16" ];

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
