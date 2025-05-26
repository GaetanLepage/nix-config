{
  wireguardClient = {
    enable = true;

    privateKeyFile = ./private-key.age;
    redirectAllTraffic = false;
    ip = "10.10.10.23";
  };
}
