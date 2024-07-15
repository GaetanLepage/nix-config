{
  hardware.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;

    pulse.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  nixpkgs.config.pulseaudio = true;
}
