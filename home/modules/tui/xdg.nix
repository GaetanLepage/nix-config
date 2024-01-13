{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.xdg-utils];

  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/videos";
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        # Applications
        "application/pdf" = "org.pwmt.zathura.desktop";

        # Text
        "text/html" = "firefox.desktop";
        "text/xml" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";

        # Images
        "image/gif" = "org.gnome.gThumb.desktop";
        "image/heif" = "org.gnome.gThumb.desktop";
        "image/jpeg" = "org.gnome.gThumb.desktop";
        "image/png" = "org.gnome.gThumb.desktop";
        "image/webp" = "org.gnome.gThumb.desktop";
        "application/octet-stream" = "org.gnome.gThumb.desktop"; # matplotlib figures

        # Videos
        "video/mp4" = "vlc.desktop"; # .mp4
        "video/quicktime" = "vlc.desktop"; # .mov
        "video/x-matroska" = "vlc.desktop"; # .mkv
        "video/x-ms-wmv" = "vlc.desktop"; # .wmv
      };
    };
  };
}
