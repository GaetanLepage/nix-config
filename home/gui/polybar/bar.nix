{
    bottom = true;
    width = "100%";
    height = 30;
    offset = { x = 0; y = 0; };
    radius = 0;
    fixed.center = false;

    background = "#0a0a0a";
    foreground = "#ffffff";

    line.size = 3;

    border = {
        size = 0;
        color = "#00";
    };

    padding = {
        left = 0;
        right = 2;
    };

    module.margin = 1;

    font = [
        "Ubuntu Nerd Font:style=Book:size=10;1'"
        "NotoSans Mono:size=6;0"

        # Font for window manager worspaces
        "DejaVu Sans Mono:size=14;4"
    ];

    modules = {
        left    = "bspwm";
        center  = "spotify";
        right   = "brightness sound ram cpu wifi battery time date vpn dunst";
    };

    tray = {
        position    = "right";
        maxsize     = 20;
    };

    wm.restack = "bspwm";

    # Scrolling through bspwm populated workspaces
    scroll = {
        up      = "bspc desktop -f prev.local.occupied";
        down    = "bspc desktop -f next.local.occupied";
    };

    # Tell the Window Manager not to configure the window.
    # Use this to detach the bar if your WM is locking its size/position.
    # Note: With this most WMs will no longer reserve space for
    # the bar and it will overlap other windows. You need to configure
    # your WM to add a gap where the bar will be placed.
    override-redirect = false;

    # Enable support for inter-process messaging
    # See the Messaging wiki page for more details.
    enable-ipc = true;

    cursor = {
        click   = "pointer";
        scroll  = "default";
    };
}
