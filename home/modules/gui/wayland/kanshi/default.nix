{
  imports = [
    ./module.nix
  ];

  services.kanshi = {
    enable = true;

    screens = {
      home = {
        criteria = "LG Electronics LG ULTRAGEAR 108MAHU2AU49";
        mode = "2560x1440@143.932999Hz";
        position = "0,0";
      };
    };
  };
}
