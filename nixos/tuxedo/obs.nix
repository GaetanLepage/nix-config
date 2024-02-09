{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (wrapOBS.override {inherit obs-studio;} {
      plugins = with obs-studio-plugins; [
        obs-composite-blur
      ];
    })
  ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
