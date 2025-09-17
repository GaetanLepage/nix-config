{
  flake.modules.homeManager.core = {
    home.shellAliases = {
      todo = "rg TODO";
      td = "rg TODO";

      ##################
      # GNU core utils #
      ##################
      c = "cd";
      rm = "rm -iv";
      cp = "cp -iv";
      mkd = "mkdir -pv";
      f = "fg";
      cat = "bat -p";

      ########
      # Misc #
      ########
      ka = "killall";
      cal = "cal -m";
      da = "doas";
      jb = "jobs";
      py = "python";
      t = "date +'%a %b %e %R:%S %Z %Y'";
      x = "xdg-open";

      ##############
      # Networking #
      ##############
      pg = "ping gnu.org";

      # Wifi
      wu = "nmcli radio wifi on";
      wd = "nmcli radio wifi off";
      edu = "nmcli radio wifi on && nmcli con up eduroam"; # inria

      # VPN
      wgu = "sudo systemctl start wg-quick-wg0";
      wgd = "sudo systemctl stop wg-quick-wg0";
      viu = "nmcli connection up vpn_inria"; # inria
      vid = "nmcli connection down vpn_inria"; # inria

      #######
      # Nix #
      #######
      d = "deploy";
      nsp = "nix-shell -p";
      nfu = "nix flake update";
      nfm = "nix fmt";
      nfc = "nix flake check --all-systems";
      nfmc = "nix fmt && nix flake check --all-systems";
    };
  };
}
