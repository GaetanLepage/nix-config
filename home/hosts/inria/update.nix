{pkgs, ...}: let
  updateScriptName = "update-home-manager";
  updateScript =
    pkgs.writeShellScriptBin
    updateScriptName
    ''
      set -e

      profile="inria"

      flake_dir="$HOME/config"

      rm -f $flake_dir/flake.lock

      git -C $flake_dir pull

      nix flake update $flake_dir

      [ -f $XDG_CONFIG_HOME/user-dirs.dirs ] && rm $HOME/.config/user-dirs.dirs

      home-manager switch --flake $flake_dir\#$profile -v

      # nix-collect-garbage --delete-older-than 2d
    '';
in {
  home = {
    packages = [updateScript];

    shellAliases = {
      # update home-manager
      un = updateScriptName;

      # update the system
      update = "sudo nala upgrade";
    };
  };
}
