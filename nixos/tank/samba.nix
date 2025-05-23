{
  # WARNING: For a user to be authenticated on the samba server, you must add their password using
  # `smbpasswd -a <user>` as root.

  services = {
    samba = {
      enable = true;

      openFirewall = true;

      settings = {
        lepage = {
          path = "/tank/lepage_family/";
          public = "no";
          writable = "yes";
          "guest ok" = "no";
          "valid users" = "anne-catherine lepage tanguy";
        };

        share = {
          path = "/tank/share/";
          public = "yes";
          writable = "yes";
          "guest ok" = "yes";
        };
      };
    };

    # make shares visible for windows clients
    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };
}
