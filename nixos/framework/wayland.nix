{
  pkgs,
  lib,
  ...
}: {
  # light (backlight control)
  programs.light.enable = true;
  users.users.gaetan.extraGroups = ["video"];

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
    greetd = {
      enable = false;
      settings.default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} --time --remember --cmd sway";
        user = "greeter";
      };
    };
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        autoNumlock = true;
        theme = "where_is_my_sddm_theme";
      };
      defaultSession = "sway";
    };

    libinput.enable = true;
    xserver.xkb.layout = "fr";
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
