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
          # regex = "(.+):\\d+";

          # Match `hostname` in `hostname-unwanted:1234`
          regex = "([^:-]+)(-.+)?:\\d+";
          target_label = "instance";
        }
      ];

      getHostnames = port:
        builtins.map
        (n: "${n}:${toString port}")
        [
          "alya"
          "auriga"
          "gpu8-perception"
        ];
    in [
      {
        job_name = "node_exporter_metrics";
        scrape_interval = "5s";
        static_configs = [
          {
            targets =
              [
                "chamaeleon:${builtins.toString config.services.prometheus.exporters.node.port}"
              ]
              ++ (getHostnames 9100);
          }
        ];
        inherit metric_relabel_configs;
      }
      {
        job_name = "dcgm_exporter";
        scrape_interval = "5s";
        static_configs = [
          {
            targets = getHostnames 9400;
          }
        ];
        inherit metric_relabel_configs;
      }
    ];

    exporters.node.enable = true;
  };
}
