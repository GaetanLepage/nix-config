{
  flake.modules.homeManager.csConfig =
    { lib, ... }:
    {
      xdg.dataFile =
        let
          paths = map (profileId: "Steam/userdata/${profileId}/730/local/cfg/autoexec.cfg") [
            "72487771" # main
            "258920647" # zarhos69
          ];
        in
        lib.genAttrs paths (_: {
          source = ./cs-autoexec.cfg;
        });
    };
}
