{ config, ... }:
{
  flake.modules.homeManager.substituters = (
    config.flake.modules.nixos.substituters // { _class = "homeManager"; }
  );
}
