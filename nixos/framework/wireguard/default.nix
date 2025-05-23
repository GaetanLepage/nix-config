{
  age.secrets.wireguard-private-key.rekeyFile = ./private-key.age;

  my-modules.wireguard = {
    enable = true;
    redirectAllTraffic = true;
    ip = "10.10.10.2";
  };
}
