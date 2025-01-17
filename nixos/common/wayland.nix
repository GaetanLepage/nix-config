{ pkgs, ... }:
{
  users.users.gaetan.extraGroups = [ "video" ];

  programs.sway.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        autoNumlock = true;
        theme = "where_is_my_sddm_theme_qt5";
      };
      defaultSession = "sway";
    };

    libinput.enable = true;
    xserver.xkb.layout = "fr";

    # Keyboard led config
    g810-led = {
      enable = true;
      profile = ''
        a ff      # Set all keys on
        c         # Commit changes
      '';
    };
  };
  environment.systemPackages = [
    (pkgs.where-is-my-sddm-theme.override {
      variants = [ "qt5" ];
      themeConfig.General = {
        background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
        backgroundMode = "fill";
        cursorColor = "#ffffff";
      };
    })
  ];
}
