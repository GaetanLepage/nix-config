{ ... }:

{
    hardware.pulseaudio.enable = false;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # Enable sound. Set to `false` if using PipeWire
    sound.enable = false;

    nixpkgs.config.pulseaudio = true;
}
