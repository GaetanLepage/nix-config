{ pkgs, ... }:

{
    users.users.gaetan.shell = pkgs.zsh;

    # https://github.com/NixOS/nixpkgs/issues/10349#issuecomment-341810990
    programs.zsh.enable = true;

    environment.pathsToLink = [ "/share/zsh" ];
}
