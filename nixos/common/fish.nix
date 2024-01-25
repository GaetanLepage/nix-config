{pkgs, ...}: {
  users.users.gaetan.shell = pkgs.fish;

  # https://github.com/NixOS/nixpkgs/issues/10349#issuecomment-341810990
  programs.fish.enable = true;

  environment.pathsToLink = ["/share/fish"];
}
