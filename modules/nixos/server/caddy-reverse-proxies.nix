{
  flake.modules.nixos.caddy-reverse-proxies =
    {
      lib,
      config,
      ...
    }:
    {
      options = {
        services.caddy = {
          reverseProxies = lib.mkOption {
            type = lib.types.attrsOf (
              lib.types.submodule {
                options = {
                  port = lib.mkOption {
                    type = with lib.types; nullOr port;
                    default = null;
                  };

                  vpn = lib.mkOption {
                    type = lib.types.bool;
                    default = false;
                  };

                  localIp = lib.mkOption {
                    type = lib.types.str;
                    default = "localhost";
                  };
                };
              }
            );
          };
        };
      };

      config =
        let
          cfg = config.services.caddy;
        in
        {
          services.caddy = {
            extraConfig = ''
              (vpn) {
                  @vpn remote_ip 10.10.10.0/24
              }
            '';

            virtualHosts = lib.mapAttrs (domain: opts: {
              extraConfig =
                let
                  proxyStr = opts.localIp + lib.optionalString (opts.port != null) ":${toString opts.port}";
                in
                if opts.vpn then
                  ''
                    import vpn
                    reverse_proxy @vpn ${proxyStr}
                  ''
                else
                  "reverse_proxy ${proxyStr}";
            }) cfg.reverseProxies;
          };
        };
    };
}
