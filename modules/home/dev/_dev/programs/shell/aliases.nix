{
  home.shellAliases = {
    todo = "rg TODO";
    td = "rg TODO";

    ##################
    # GNU core utils #
    ##################
    c = "cd";
    rm = "rm -iv";
    cp = "cp -iv";
    mkd = "mkdir -pv";
    f = "fg";
    cat = "bat -p";

    ########
    # Misc #
    ########
    s = "ssh";
    ka = "killall";
    cal = "cal -m";
    da = "doas";
    jb = "jobs";
    py = "python";
    t = "date +'%a %b %e %R:%S %Z %Y'";
    x = "xdg-open";

    ##############
    # Networking #
    ##############
    pg = "ping gnu.org";

    # Wifi
    wu = "nmcli radio wifi on";
    wd = "nmcli radio wifi off";

    # VPN
    wgu = "sudo systemctl start wg-quick-wg0";
    wgd = "sudo systemctl stop wg-quick-wg0";

    #######
    # Nix #
    #######
    d = "deploy";
    nsp = "nix-shell -p";
    nfu = "nix flake update";
    nfc = "nix flake check";
  };
}
