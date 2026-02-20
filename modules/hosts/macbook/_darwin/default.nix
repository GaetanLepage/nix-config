{ pkgs, ... }:
{
  imports = [
    ./programs.nix
    ./system-settings.nix
    ./karabiner.nix
    # ./yabai.nix
  ];

  # use fingerprint for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  fonts.packages = with pkgs; [
    noto-fonts
    nerd-fonts.dejavu-sans-mono
  ];
}
