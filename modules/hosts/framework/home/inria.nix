{
  flake.modules.homeManager.host_framework =
    { pkgs, ... }:
    {
      # inria
      home.packages = with pkgs; [
        pdfsam-basic
        texlive.combined.scheme-full
        liberation-sans-narrow
      ];
    };
}
