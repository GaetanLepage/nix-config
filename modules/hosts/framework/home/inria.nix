{
  flake.modules.homeManager.host_framework =
    { pkgs, ... }:
    {
      services.kanshi = {
        screens.inria = {
          criteria = "Dell Inc. DELL U2719DC 88QSTS2";
          position = "0,0";
          mode = "2560x1440@59.95Hz";
        };
        _profiles.inria = {
          screens = {
            laptop.status = "disable";
            inria.status = "enable";
          };
          wifi = true;
        };
      };

      # inria
      home.packages = with pkgs; [
        pdfsam-basic
        texlive.combined.scheme-full
        liberation-sans-narrow
      ];
    };
}
