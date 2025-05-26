{
  age.secrets.wireguard-private-key.rekeyFile = ./private-key.age;

  wireguardClient = {
    enable = true;
    redirectAllTraffic = true;
    ip = "10.10.10.2";
  };
}
