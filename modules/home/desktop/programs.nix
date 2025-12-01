{
  flake.modules.homeManager.desktop-programs =
    { pkgs, ... }:
    {
      programs.nheko.enable = true;

      home.packages = with pkgs; [
        # IM
        discord
        signal-desktop

        # Office / productivity
        libreoffice-fresh
        zotero # inria

        # Misc
        losslesscut-bin
        spotify
      ];
    };
}
