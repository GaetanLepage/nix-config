{
  flake.modules.homeManager.host_framework =
    { pkgs, ... }:
    {
      # inria
      home.packages = with pkgs; [
        pdfsam-basic
        liberation-sans-narrow
      ];
    };
}
