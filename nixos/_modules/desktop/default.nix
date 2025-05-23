{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.my-modules.desktop;
in
{
  options = {
    my-modules.desktop = {
      enable = lib.mkEnableOption "";
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (import ./obs.nix { inherit pkgs; })
      (import ./printing.nix)
      (import ./thunar.nix)
      (import ./wayland.nix { inherit pkgs; })
      {
        services = {
          gnome.gnome-keyring.enable = true;
          udisks2.enable = true;

          # Keyboard led config
          g810-led = {
            enable = true;
            profile = ''
              a ff      # Set all keys on
              c         # Commit changes
            '';
          };
        };

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
      }
    ]
  );
}
