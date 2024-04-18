{config, ...}: {
  # networking.firewall.allowedTCPPorts = [
  #   config.services.prometheus.port
  # ];

  services.prometheus = {
    enable = true;

    # Only listen to the local interface instead of using the `0.0.0.0` default.
    listenAddress = "127.0.0.1";

    scrapeConfigs = let
      metric_relabel_configs = [
        {
          source_labels = ["instance"];

          # Match `hostname` in `hostname:1234`
          # regex = "(.+):\d+";

          # Match `hostname` in `hostname-unwanted:1234`
          regex = "([a-z]+)[-]?[a-z]*:\d+";
          target_label = "instance";
        }
      ];
    in [
      {
        job_name = "node_exporter_metrics";
        scrape_interval = "5s";
        static_configs = [
          {
            targets = [
              "localhost:${builtins.toString config.services.prometheus.exporters.node.port}"
              "alya:9100"
              "auriga:9100"
              "gpu8-perception:9100"
            ];
          }
        ];
        inherit metric_relabel_configs;
      }
      {
        job_name = "dcgm_exporter";
        scrape_interval = "5s";
        static_configs = [
          {
            targets = [
              "alya:9400"
              "auriga:9400"
              "gpu8-perception:9400"
            ];
          }
        ];
        inherit metric_relabel_configs;
      }
    ];

    exporters.node.enable = true;
  };
}
