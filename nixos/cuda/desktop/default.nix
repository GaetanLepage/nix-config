{ pkgs, ... }:
{
  imports = [
    ./sound.nix
    ./xorg.nix
  ];

  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
      autoSuspend = false;
    };

    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Gnome extensions
    gnomeExtensions.dash-to-panel
    gnomeExtensions.vitals

    # GUI
    discord
    firefox
    mpv
    mumble
    signal-desktop
    spotify
    teamspeak_client
    thunderbird
  ];
}
