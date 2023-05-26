{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Misc (system utilities)
    killall
    nfs-utils # Linux user-space NFS utilities
    nix-index

    # Network
    dig # Domain name server
    lsof
    speedtest-rs
    wol # Wake on Lan

    # Software development
    git

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

    # Hardware Monitoring
    htop
  ];
}
