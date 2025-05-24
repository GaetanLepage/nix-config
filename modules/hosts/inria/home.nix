{
  flake.modules.homeManager.host_inria =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      home = {
        username = "galepage";
        homeDirectory = "/home/galepage";

        sessionVariables = {
          LD_PRELOAD = "/lib/x86_64-linux-gnu/libnss_sss.so.2";
        };
      };

      programs.btop.enable = lib.mkForce false;

      xdg.userDirs = lib.mapAttrs (n: v: lib.mkForce "${config.home.homeDirectory}/${v}") {
        desktop = "Desktop";
        documents = "Documents";
        download = "Downloads";
        music = "Music";
        pictures = "Pictures";
        publicShare = "Public";
        templates = "Templates";
        videos = "Videos";
      };

      nix.package = pkgs.nix;
    };
}
