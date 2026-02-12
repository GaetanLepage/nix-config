{
  config,
  primaryUser,
  ...
}:
let
  seedingPorts = [
    16881
    6881
  ];
in
{
  age.secrets.deluge_auth_file = {
    rekeyFile = ./deluge-auth-file.age;
    owner = config.services.deluge.user;
    inherit (config.services.deluge) group;
  };

  users.users.${primaryUser}.extraGroups = [
    config.services.deluge.group
  ];

  networking.firewall = {
    allowedTCPPorts = seedingPorts;
    allowedUDPPorts = seedingPorts;
  };

  services = {
    caddy.reverseProxies."deluge.glepage.com" = {
      inherit (config.services.deluge.web) port;
      vpn = true;
    };

    deluge = {
      enable = true;

      declarative = true;
      authFile = config.age.secrets.deluge_auth_file.path;

      web.enable = true;

      config = {
        download_location = "/tank/tmp/deluge";
        max_active_downloading = 20;
        max_active_limit = 200;

        # random_port = false;
        listen_random_port = false;
        listen_ports = seedingPorts;
        max_active_seeding = 200;
        max_upload_slots_global = 200;

        # Route all traffix through mullvad
        listen_interface = "mullvad";
        outgoing_interface = "mullvad";
      };
    };
  };
}
