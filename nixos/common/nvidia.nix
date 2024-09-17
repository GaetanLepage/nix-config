# inria: this can be moved in cuda when chamaeleon will be gone
{
  lib,
  config,
  pkgs,
  ...
}: {
  options.my-modules.nvidia = {
    enable = lib.mkEnableOption "nvidia";
  };

  config = let
    cfg = config.my-modules.nvidia;
  in
    lib.mkIf cfg.enable {
      # nixpkgs.config.cudaSupport = true;

      services.xserver.videoDrivers = ["nvidia"];

      environment.systemPackages = [pkgs.nvtopPackages.nvidia];

      hardware = {
        graphics = {
          enable = true;
          enable32Bit = true;
        };

        nvidia = {
          # Modesetting is required.
          modesetting.enable = true;

          # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
          powerManagement.enable = false;
          # Fine-grained power management. Turns off GPU when not in use.
          # Experimental and only works on modern Nvidia GPUs (Turing or newer).
          powerManagement.finegrained = false;

          # Use the NVidia open source kernel module (not to be confused with the
          # independent third-party "nouveau" open source driver).
          # Support is limited to the Turing and later architectures. Full list of
          # supported GPUs is at:
          # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
          # Only available from driver 515.43.04+
          # Currently alpha-quality/buggy, so false is currently the recommended setting.
          open = false;

          # Enable the Nvidia settings menu,
          # accessible via `nvidia-settings`.
          nvidiaSettings = true;
        };
      };
    };
}
