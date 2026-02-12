{ primaryUser, ... }:
{
  users = {
    users = {
      lepage = {
        uid = 1004;
        group = "lepage";
        isNormalUser = true;
      };

      tanguy = {
        uid = 1005;
        group = "tanguy";
        isNormalUser = true;
      };

      anne-catherine = {
        uid = 1010;
        group = "lepage";
        isNormalUser = true;
      };

      francis = {
        isNormalUser = true;
        group = "lepage";

        openssh.authorizedKeys.keys = [
          # SSH key for borg backups
          # Backup destination: /tank/lepage_family/backup/fl_macbook/
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA4jMzH/oCEPsHYi0kph6/iDJV02V2NE1LLj9fPaD/rz francis@Host-003.lan"
        ];
      };
    };

    groups = {
      lepage = {
        gid = 1005;

        members = [
          "lepage"
          primaryUser
          "tanguy"
          "anne-catherine"
        ];
      };

      tanguy = {
        gid = 1006;

        members = [ "tanguy" ];
      };
    };
  };
}
