{
  inputs,
  lib,
  ...
}:
{
  perSystem =
    { inputs', ... }:
    {
      devshells.default.packages = [
        inputs'.dnscontrol-nix.packages.default
      ];
    };

  flake.dns = inputs.dnscontrol-nix.lib.buildConfig {
    settings.credsCommand = "agenix view ${./creds.age}";
    domains = {
      glepage = {
        domain = "glepage.com";
        registrar = "ovh";
        dnsProvider = "ovh";

        records =
          let
            vpsIpv4 = "91.99.205.143";
            vpsIpv6 = "2a01:4f8:1c1c:eb4::64";
            feroeIpv4 = "89.80.115.41";

            hostRecords =
              lib.mapAttrsToList
                (hostname: address: {
                  type = "a";
                  label = hostname;
                  inherit address;
                })
                {
                  cuda = feroeIpv4;
                  feroe = feroeIpv4;
                  tank = feroeIpv4;
                  vps = vpsIpv4;
                };

            mailRecords = [
              {
                type = "a";
                label = "mail";
                address = vpsIpv4;
              }
              {
                type = "aaaa";
                label = "mail";
                address = vpsIpv6;
              }
              {
                type = "txt";
                label = "@";
                text = "v=spf1 a:mail.glepage.com -all";
              }
              {
                type = "txt";
                label = "_dmarc";
                text = "v=DMARC1;p=none;";
              }
              {
                type = "txt";
                label = "mail._domainkey";
                text =
                  let
                    key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7BUIfR3QWg4NYFGKo2e2pz42d8Xtsa3TPusvt45RxIRir5MY5JUL70Hhrsyv7e0pCudBuJ3/Hbr2FEm4K1vw43kTAOAzhExwkxe1eGkKPfZtv8U/s/RSEjkwC9yH3vNcl8N9RSNEOhQ6lu7FFI7Fq160BU4rL6wsSiSKQaCvBsYX8ZqwFw/y0+ZFXZe7tfd0HORGxX3U5TXH4jElC8ZPxfc6rfuL+czRiyAnuZ1AVBxoQcSyCGu+rrLCvym5qP3FWZcXIx8LCuua8IfWTn6O8+ZnGxubcXSPGr7K3pbGAa6+d3WPpQKk/k/dm6BNWmQWDdOe5C4DRbdEO0TFyFDB/wIDAQAB";
                  in
                  "v=DKIM1;p=${key}";
              }
              {
                type = "txt";
                label = "ownercheck.mail";
                text = "e1c14c1b";
              }
              {
                type = "mx";
                label = "@";
                priority = 10;
                target = "mail";
              }
            ];

            # Move this to host definitions
            serviceRecords =
              lib.mapAttrsToList
                (service: host: {
                  type = "cname";
                  label = service;
                  target = host;
                })
                {
                  bitwarden = "vps";
                  board = "vps";
                  paste = "vps";
                  bbox = "vps";
                  adguard = "vps";
                  cloud = "tank";
                  deluge = "tank";
                  dns = "vps";
                  invidious = "tank";
                  jellyfin = "vps";
                  meet = "vps";
                  mumble = "vps";
                  notes = "vps";
                  onlyoffice = "tank";
                  photos = "tank";
                  vpn = "vps";
                  webmail = "vps";
                };
          in
          hostRecords
          ++ serviceRecords
          ++ mailRecords
          ++ [
            {
              type = "a";
              label = "@";
              address = vpsIpv4;
            }
            # Bluesky
            {
              type = "txt";
              label = "_atproto";
              text = "did=did:plc:dxqyu7dirrjse6jvviq7dyaw";
            }
          ];
      };
    };
  };
}
