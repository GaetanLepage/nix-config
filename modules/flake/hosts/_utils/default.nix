{ lib, inputs, ... }:
{
  baseHostModule = import ./base.nix { inherit lib inputs; };
}
