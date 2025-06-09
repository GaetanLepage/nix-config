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
    };

    groups = {
      lepage = {
        gid = 1005;

        members = [
          "lepage"
          "gaetan"
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
