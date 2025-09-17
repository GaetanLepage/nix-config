{
  flake.modules.homeManager.host_jrs =
    { pkgs, ... }:
    {
      home.username = "glepage";
    };
}
