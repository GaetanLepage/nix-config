{ ... }:

{
    xdg = {
        enable = true;

        userDirs = {
            enable = true;

            desktop     = "$HOME/desktop";
            documents   = "$HOME/documents";
            download    = "$HOME/downloads";
            music       = "$HOME/music";
            pictures    = "$HOME/pictures";
            publicShare = "$HOME/public";
            templates   = "$HOME/templates";
            videos      = "$HOME/videos";

        };

        mimeApps = {
            enable = true;

            defaultApplications = {
                # Applications
                "application/pdf"   = "org.pwmt.zathura.desktop";

                # Text
                "text/html"         = "firefox.desktop";
                "text/xml"          = "firefox.desktop";

                # Images
                "image/gif"         = "mpvgif.desktop";
                "image/heif"        = "org.gnome.gThumb.desktop";
                "image/jpeg"        = "org.gnome.gThumb.desktop";
                "image/png"         = "org.gnome.gThumb.desktop";

                # Videos
                "video/mp4"         = "vlc.desktop";    # .mp4
                "video/quicktime"   = "vlc.desktop";    # .mov
                "video/x-matroska"  = "vlc.desktop";    # .mkv
                "video/x-ms-wmv"    = "vlc.desktop";    # .wmv
            };
        };
    };
}
