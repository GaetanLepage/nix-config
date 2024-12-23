{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pavucontrol
    playerctl

    # Even though using Pipewire, pulseaudio provides `pactl`
    pulseaudio
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
