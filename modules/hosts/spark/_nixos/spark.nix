{ inputs, ... }:
{
  imports = [
    inputs.dgx-spark.nixosModules.dgx-spark
  ];

  hardware.dgx-spark.enable = true;
}
