{
  flake.modules.nixos.desktop =
    { pkgs, primaryUser, ... }:
    {
      users.users.${primaryUser}.extraGroups = [ "video" ];

      security.polkit.enable = true;

      programs.sway = {
        enable = true;

        # Prevent extra packages from being automatically installed along sway
        extraPackages = [ ];

        # Discord is the only application needing xwayland
        # TODO: disable when possible
        xwayland.enable = true;
      };

      fonts.packages = with pkgs; [
        noto-fonts
        nerd-fonts.dejavu-sans-mono
        nerd-fonts.ubuntu-mono
      ];

      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
        ];
      };

      services = {
        displayManager.defaultSession = "sway";

        libinput.enable = true;
        xserver.xkb.layout = "fr";
      };
    };
}
