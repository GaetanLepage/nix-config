let
  tensorboardUrl = "tensorboard.glepage.com";
  tensorboardIp = "10.10.10.4";
in
{
  # DNS record
  networking.hosts.${tensorboardUrl} = [ tensorboardIp ];

  services.caddy =
    let
      domain = "robotlearn.ovh";
    in
    {
      virtualHosts = {
        ${tensorboardUrl}.extraConfig = ''
          import vpn
          handle @vpn {

              handle_path /rlan/* {
                  reverse_proxy 10.10.10.4:9090
              }
              handle_path /exputils/* {
                  reverse_proxy 10.10.10.4:9091
              }
          }
        '';
        "wiki.${domain}".extraConfig = ''
          redir https://robotlearn.gitlabpages.inria.fr/wiki/
        '';
      };

      reverseProxies = {
        ${domain} = {
          localIp = "10.10.10.7";
          port = 8000;
        };

        "ollama.${domain}" = {
          localIp = "10.10.10.4"; # auriga
          port = 11434;
        };
      };
    };
}
