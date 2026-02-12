{ config, inputs, ... }:
{
  flake.modules.nixos.core.imports = with config.flake.modules.nixos; [
    inputs.disko.nixosModules.disko

    agenix
    bootloader
    nh
    security
    ssh-server
    users
    wireguard-client
  ];
}
