{
  wireguardClient = {
    enable = true;

    privateKeyFile = ./private-key.age;
    redirectAllTraffic = true;
    ip = "10.10.10.4";
  };
}
