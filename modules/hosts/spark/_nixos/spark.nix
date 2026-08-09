{ inputs, ... }:
{
  imports = [
    inputs.dgx-spark.nixosModules.dgx-spark
  ];

  hardware.dgx-spark.enable = true;

  # This machine can run cuda tests
  programs.nix-required-mounts = {
    enable = true;
    presets.nvidia-gpu.enable = true;
  };
}
