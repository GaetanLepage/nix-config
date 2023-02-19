{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Misc (system utilities)
    acpilight # Screen brightness control
    home-manager # A user environment configurator
    killall
    nfs-utils # Linux user-space NFS utilities
    nix-index
    xclip
    xorg.xbacklight
    xorg.xev
    xorg.xkill
    xorg.xmodmap

    # Network
    dig # Domain name server
    lsof
    speedtest-cli
    wol # Wake on Lan

    # Software development
    git

    # Shell
    bash

    # CLI utilities
    file
    ncdu
    tree
    unzip
    wget
    zip

    # Multimedia
    ffmpeg
    ffmpegthumbnailer
    gthumb
    imagemagick
    mpv
    vlc

    # Window manager
    bspwm

    # Hardware Monitoring
    htop
  ];
}
