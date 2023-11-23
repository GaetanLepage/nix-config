{
  todo = "rg TODO";
  td = "rg TODO";

  vt = "vim ~/perso/notes/todo.norg";

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
  icat = "kitty +kitten icat";
  jb = "jobs";
  lo = "soffice";
  ns = "nvidia-smi";
  py = "python";
  t = "date +'%a %b %e %R:%S %Z %Y'";
  u = "update";
  wttr = "curl wttr.in/Grenoble+38000";
  x = "xdg-open";

  ##############
  # NFS mounts #
  ##############
  ms = "sudo mount 10.10.10.1:/tank /mnt/server && notify-send 'server mounted'";
  us = "sudo umount /mnt/server && notify-send 'server unmounted'";

  ##############
  # Networking #
  ##############
  pg = "ping gnu.org";

  # Wifi
  wu = "nmcli radio wifi on";
  wd = "nmcli radio wifi off";
  edu = "nmcli radio wifi on && nmcli con up eduroam";

  # VPN
  wgu = "sudo systemctl start wg-quick-wg0";
  wgd = "sudo systemctl stop wg-quick-wg0";
  viu = "nmcli connection up vpn_inria";
  vid = "nmcli connection down vpn_inria";
  veu = "nmcli connection up vpn_ensimag";
  ved = "nmcli connection down vpn_ensimag";

  #######
  # Nix #
  #######
  nrs = "sudo nixos-rebuild switch --flake ~/config -v";
  ncg = "sudo nix-collect-garbage";
  hms = "home-manager switch";
  hme = "home-manager edit";
  nsp = "nix-shell -p";
  nfu = "nix flake update";
  nfm = "nix fmt";
  nfc = "nix flake check --all-systems";
  nfmc = "nix fmt && nix flake check --all-systems";
  uc = "nixos-rebuild switch --fast --flake ~/config#cuda --target-host root@cuda --build-host root@cuda";
}
