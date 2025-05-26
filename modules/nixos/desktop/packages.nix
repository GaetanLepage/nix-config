{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      # Needed by the nheko matrix client
      nixpkgs.config.permittedInsecurePackages = [ "olm-3.2.16" ];

      environment.systemPackages = with pkgs; [
        discord

        # Multimedia
        ffmpeg
        ffmpegthumbnailer
        gthumb
        imagemagick
        mpv
        vlc
      ];
    };
}
