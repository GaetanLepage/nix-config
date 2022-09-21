{
    xsession = {
        enable = true;
        numlock.enable = true;

        # Increase key speed via a rate change
        profileExtra = ''
            xset r rate 300 50
        '';
    };


    home.keyboard = {
        layout = "fr";
        options = [ "caps:swapescape" ];
    };
}
