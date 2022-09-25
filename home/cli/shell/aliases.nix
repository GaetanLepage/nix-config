{
    todo = "rg TODO";
    td = "rg TODO";

    tt = "touchpad_toggle";


    ##################
    # GNU core utils #
    ##################
    c   = "cd";
    rm  = "rm -iv";
    cp  = "cp -iv";
    mkd = "mkdir -pv";
    f   = "fg";


    ########
    # Misc #
    ########
    bu      = "backup";
    ka      = "killall";
    cal     = "cal -m";
    icat    = "kitty +kitten icat";
    jb      = "jobs";
    lo      = "libreoffice";
    ns      = "nvidia-smi";
    py      = "python";
    t       = "date +'%a %b %e %R:%S %Z %Y'";
    u       = "update";
    wttr    = "curl wttr.in/Grenoble+38000";
    x       = "xdg-open";


    ##############
    # NFS mounts #
    ##############
    ms  = "sudo mount 10.10.10.1:/tank /mnt/server && dunstify 'server mounted'";
    us  = "sudo umount /mnt/server && dunstify 'server unmounted'";


    ##############
    # Networking #
    ##############
    pg  = "ping gnu.org";

    # Wifi
    wu  = "nmcli radio wifi on";
    wd  = "nmcli radio wifi off";
    edu = "nmcli radio wifi on && nmcli con up eduroam";

    # VPN
    wgu = "sudo systemctl start wg-quick-wg0";
    wgd = "sudo systemctl stop wg-quick-wg0";
    viu = "nmcli connection up vpn_inria";
    vid = "nmcli connection down vpn_inria";
    veu = "nmcli connection up vpn_ensimag";
    ved = "nmcli connection down vpn_ensimag";


    #######
    # Nix #
    #######
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/.";
    ncg = "sudo nix-collect-garbage";
    hms = "home-manager switch";
    hme = "home-manager edit";
    nsp = "nix-shell -p";
}
