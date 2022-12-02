{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [

        pavucontrol
        playerctl

        # Even though using Pipewire, pulseaudio provides `pactl`
        pulseaudio
    ];

    hardware.pulseaudio.enable = false;

    services.pipewire = {
        enable = true;

        pulse.enable = true;

        alsa = {
            enable = true;
            support32Bit = true;
        };
    };

    # Enable sound. Set to `false` if using PipeWire
    sound.enable = false;

    nixpkgs.config.pulseaudio = true;
}
