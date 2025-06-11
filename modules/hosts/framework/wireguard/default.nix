{
  flake.modules.nixos.host_framework = {
    wireguardClient = {
      enable = true;

      privateKeyFile = ./private-key.age;
      redirectAllTraffic = true;
      ip = "10.10.10.2";
    };
  };
}
