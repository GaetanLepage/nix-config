{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # Misc (system utilities)
        acpilight                   # Screen brightness control
        home-manager                # A user environment configurator
        killall
        nfs-utils                   # Linux user-space NFS utilities
        nix-index
        udiskie
        xclip
        xorg.xbacklight
        xorg.xev
        xorg.xkill
        xorg.xmodmap

        # Audio
        pavucontrol
        pulseaudio                  # Even though using Pipewire, pulseaudio provides `pactl`
        playerctl

        # Network
        dig                         # Domain name server
        networkmanagerapplet
        lsof
        speedtest-cli
        wol                         # Wake on Lan

        # Software development
        git
        texlive.combined.scheme-full

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

        # GUI applications
        discord
        firefox
        element-desktop
        jitsi-meet-electron
        libreoffice-fresh
        okular
        pcmanfm
        signal-desktop
        slack
        spotify
        thunderbird
        zathura
        zotero

        # Misc
        hugo
    ];
}
