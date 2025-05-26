{
  flake.modules.nixos.obs =
    { pkgs, ... }:
    {
      programs.obs-studio = {
        enable = true;

        plugins = with pkgs.obs-studio-plugins; [
          obs-composite-blur
        ];
      };
    };
}
