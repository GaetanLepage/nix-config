{
  flake.modules.homeManager.desktop-programs =
    { pkgs, ... }:
    {
      programs.nheko.enable = true;

      home.packages = with pkgs; [
        ## GUI applications
        inkscape # inria
        drawio # inria

        # IM
        discord
        signal-desktop
        slack # inria

        # Office / productivity
        libreoffice-fresh
        kdePackages.okular # inria ? (also delete keyboard shortcuts file)
        zotero # inria

        # Misc
        spotify
      ];
    };
}
