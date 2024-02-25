{pkgs, ...}: {
  # light (backlight control)
  programs.light.enable = true;
  users.users.gaetan.extraGroups = ["video"];

  programs.sway.enable = true;
  # programs.river.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  services.xserver = {
    enable = true;

    xkb.layout = "fr";

    libinput.enable = true;

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        autoNumlock = true;
        theme = "where_is_my_sddm_theme";
      };
      defaultSession = "sway";
    };
  };
  environment.systemPackages = [
    (pkgs.where-is-my-sddm-theme.override {
      themeConfig.General = {
        background = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
        backgroundMode = "fill";
        cursorColor = "#ffffff";
      };
    })
  ];

  services.geoclue2.enable = true;
}
