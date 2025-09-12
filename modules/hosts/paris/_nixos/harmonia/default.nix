{ config, ... }:
let
  port = 5000;
in
{
  # Public and private keys
  # Generated with: `nix-store --generate-binary-cache-key cache.glepage.com private public`
  # Public: cache.glepage.com:iaI4fkpeSy8sg8u5M8KnMsl4mSS1vwMYWj+ipqz9ugg=
  age.secrets.harmonia-private-key.rekeyFile = ./harmonia-private-key.age;

  services.harmonia = {
    enable = true;

    signKeyPaths = [
      config.age.secrets.harmonia-private-key.path
    ];

    settings.bind = "${config.wireguardClient.ip}:${toString port}";
  };

  systemd.services.harmonia.after = [
    # Ensure Wireguard has started before running harmonia
    "wg-quick-wg0.service"
  ];

  networking.firewall.allowedTCPPorts = [ port ];
}
