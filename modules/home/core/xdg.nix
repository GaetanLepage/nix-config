{
  flake.modules.homeManager.xdg =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      home = {
        packages = [ pkgs.xdg-utils ];

        # Make programs use XDG directories whenever supported
        preferXdgDirectories = true;
      };

      xdg = {
        enable = true;

        userDirs = {
          enable = true;
        }
        // (lib.mapAttrs (_: folderName: "${config.home.homeDirectory}/${folderName}") {
          desktop = "desktop";
          documents = "documents";
          download = "downloads";
          music = "music";
          pictures = "pictures";
          publicShare = "public";
          templates = "templates";
          videos = "videos";
        });

        mimeApps = {
          enable = pkgs.stdenv.hostPlatform.isLinux;

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
            "image/svg+xml" = "org.gnome.gThumb.desktop";
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
    };
}
