{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # Misc (system utilities)
        acpilight                   # Screen brightness control
        arandr
        autorandr
        cachix
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
        ctags
        git
        lazygit     # TODO move to home
        texlive.combined.scheme-full

        # Shell
        bash
        zsh
        pfetch

        # CLI utilities
        bat
        exa
        fzf
        file
        ncdu
        poppler_utils               # A PDF rendering library (used by `ranger` to preview PDFs)
        ranger
        ripgrep
        tmux
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
        betterlockscreen
        bspwm
        dunst
        mons
        picom
        polybar
        rofi
        xwallpaper

        # Hardware Monitoring
        btop
        htop

        # GUI applications
        discord
        firefox
        flameshot
        element-desktop
        jitsi-meet-electron
        libreoffice-fresh
        mumble
        nextcloud-client
        okular
        pcmanfm
        pdfsam-basic
        signal-desktop
        slack
        spotify
        thunderbird
        zathura
        zotero

        # Languages
        clang
        gcc
        python3
    ];
}
