{pkgs, ...}: {
  # light (backlight control)
  programs.light.enable = true;
  users.users.gaetan.extraGroups = ["video"];

  programs.sway.enable = true;
  # programs.river.enable = true;

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

    layout = "fr";

    libinput.enable = true;

    displayManager = {
      gdm.enable = true;
      defaultSession = "sway";
      # defaultSession = "river";
    };
  };
}
