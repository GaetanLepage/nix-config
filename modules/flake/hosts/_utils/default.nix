{ lib, inputs }:
{
  baseHostModule = import ./base.nix { inherit lib inputs; };
  homeManagerModule = import ./home-manager.nix { inherit lib; };
}
