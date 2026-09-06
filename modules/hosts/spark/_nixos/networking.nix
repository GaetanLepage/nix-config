{
  systemd.network = {
    enable = true;
    networks."10-lan" = {
      matchConfig.Name = "enP7s7";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
        # No temp address
        IPv6PrivacyExtensions = "no";
      };
      ipv6AcceptRAConfig.Token = "static:::100";
    };
  };

  networking = {
    useNetworkd = true;
    useDHCP = false;

    tempAddresses = "disabled";
  };
}
