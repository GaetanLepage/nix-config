{
  flake.modules.homeManager.core =
    {
      lib,
      pkgs,
      ...
    }:
    let
      package = pkgs.writeShellApplication {
        name = "update_nixpkgs_package";

        runtimeInputs = with pkgs; [
          gawk
          git
          gh
        ];

        text = builtins.readFile ./update-package.sh;
      };
    in
    {
      home = {
        packages = [
          package
        ];

        shellAliases = {
          npu = lib.getExe package;
        };
      };

      programs.fish.functions = {
        npup = "${lib.getExe package} python3Packages.$argv[1]";
      };
    };
}
