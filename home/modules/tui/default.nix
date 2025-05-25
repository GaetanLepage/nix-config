{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./dev
    ./git.nix
    ./monitoring.nix
    ./neovim
    ./nix.nix
    ./shell
    ./ssh
    ./tmux.nix
    ./update.nix
    ./xdg.nix
    ./yazi.nix
    ./zellij.nix
  ];

  programs = {
    bat.enable = true;
    fd.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
  };

  home = {
    username = lib.mkDefault "gaetan"; # inria (remove mkDefault)
    homeDirectory = lib.mkDefault "/home/gaetan"; # inria

    packages = with pkgs; [
      # Rust implementations of linux commands
      du-dust # du
      dua # du
      dysk # df
      procs # ps

      # Other utils
      mprocs
      ncdu
      tlrc
      wget

      # Network
      dig
    ];
  };
}
