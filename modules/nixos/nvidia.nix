{
  flake.modules.nixos.nvidia =
    { pkgs, config, ... }:
    {
      # PROPRIERARY DRIVER #######################################################################
      nixpkgs.config.cudaSupport = true;
      services.xserver.videoDrivers = [ "nvidia" ];
      environment.systemPackages = [ pkgs.nvtopPackages.nvidia ];
      programs.sway.package = pkgs.sway.override { extraOptions = [ "--unsupported-gpu" ]; };
      ############################################################################################

      # This machine can run cuda tests
      programs.nix-required-mounts = {
        enable = true;
        presets.nvidia-gpu.enable = true;
      };

      hardware = {
        graphics = {
          enable = true;
          enable32Bit = true;
        };

        nvidia = {
          # Use latest drivers
          package = config.boot.kernelPackages.nvidiaPackages.latest;

          # Modesetting is required.
          modesetting.enable = true;

          # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
          powerManagement.enable = false;
          # Fine-grained power management. Turns off GPU when not in use.
          # Experimental and only works on modern Nvidia GPUs (Turing or newer).
          powerManagement.finegrained = false;

          # Use the NVidia open source kernel module
          open = true;

          # Enable the Nvidia settings menu,
          # accessible via `nvidia-settings`.
          nvidiaSettings = true;
        };
      };
    };
}
