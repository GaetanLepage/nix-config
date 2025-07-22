{
  # inria
  flake.modules.homeManager.core = {
    home.shellAliases = {
      # Files
      rp = "remi push";
      rpf = "remi push -f";
      rpl = "remi pull";
      rcl = "remi clean";

      # Singularity
      rbc = "remi build-container";

      # Desktop
      rd = "remi desktop";
      rdc = "remi desktop command";
      rdi = "remi desktop interactive";
      rda = "remi desktop attach-session";

      # Cluster
      rc = "remi cluster";
      rcc = "remi cluster command";
      rci = "remi cluster interactive";
      rcst = "remi cluster stat";
      rck = "remi cluster kill";

      # Gricad
      rgs = "remi gricad script";
      rgc = "remi gricad command";
      rgi = "remi gricad interactive";
      rgst = "remi gricad stat";
      rgch = "remi gricad chandler";
      rgr = "remi gricad recap";
      rgk = "remi cluster kill";

      # Remote servers
      rt = "remi tensorboard";
      rst = "remi ssh-tunnel";
    };
  };
}
