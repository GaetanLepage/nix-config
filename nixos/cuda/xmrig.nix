{
  services = {
    tor = {
      enable = true;
      client.enable = true;
    };

    xmrig = {
      enable = true;

      settings = {
        autosave = true;

        cpu = true;
        opencl = false;
        cuda = false;


        donate-level = 5;
        donate-over-proxy = 1;

        pools = [
          {
            url = "hashvaultsvg2rinvxz7kos77hdfm6zrd5yco3tx2yh2linsmusfwyad.onion:443";
            user = "42TKvj5ene15GbhR9J88oxHY1aRZxCg2sbdUbffjz8K3iK9eHEByJSUVHRyPTpp3UrXdDj1NMANG818nKKQCGTNaR5PGT9X";
            pass = "cuda";
            keepalive = true;
            tls = false;
            socks5 = 9050;
          }
        ];
      };
    };
  };
}
