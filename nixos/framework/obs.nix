{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (wrapOBS.override {inherit obs-studio;} {
      plugins = with obs-studio-plugins; [
        obs-composite-blur
      ];
    })
  ];
}
