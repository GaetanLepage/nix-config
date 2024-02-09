{pkgs, ...}: {
  users.users.gaetan.shell = pkgs.fish;

  programs.fish.enable = true;

  environment.pathsToLink = ["/share/fish"];
}
