{
  age.secrets.wireguard-private-key.rekeyFile = ./private-key.age;

  my-modules.wireguard = {
    enable = true;
    redirectAllTraffic = false;
    ip = "10.10.10.23";
  };
}
