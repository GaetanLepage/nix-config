{
  age.secrets.wireguard-private-key.rekeyFile = ./private-key.age;

  wireguardClient = {
    enable = true;
    redirectAllTraffic = false;
    ip = "10.10.10.8";
  };
}
