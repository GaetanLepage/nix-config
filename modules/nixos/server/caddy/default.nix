{
  flake.modules.nixos.caddy =
    { primaryUser, ... }:
    {
      services.caddy = {
        enable = true;
      };

      imports = [
        ./_reverse-proxies.nix
      ];

      # Open HTTP and HTTPS ports
      networking.firewall.allowedTCPPorts = [
        80
        443
      ];

      users.users.${primaryUser}.extraGroups = [ "caddy" ];
    };
}
