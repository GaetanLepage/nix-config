{config, ...}: {
  networking.firewall.allowedTCPPorts = [
    config.services.grafana.settings.server.http_port
  ];

  services.grafana = {
    enable = true;

    settings = {
      "auth.anonymous".enabled = true;
      server = {
        # domain = "robotlearn-grafana.glepage.com";
        http_addr = "0.0.0.0";
        # enforce_domain = false;
        root_url = "https://robotlearn-grafana.glepage.com";
      };
    };

    provision = {
      datasources.settings.datasources = [
        {
          name = "prometheus";
          type = "prometheus";
          url = "http://localhost:9090";
        }
      ];
      dashboards = {
      };
    };
  };
}
