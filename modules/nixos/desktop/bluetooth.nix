{
  flake.modules.nixos.bluetooth = {
    services.blueman.enable = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
