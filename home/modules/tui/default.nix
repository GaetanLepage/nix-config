{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./btop.nix
    ./dev
    ./git.nix
    ./neovim
    ./nix.nix
    ./shell
    ./ssh
    ./tmux.nix
    ./xdg.nix
    ./yazi.nix
    ./zellij.nix
    inputs.nix-index-database.hmModules.nix-index
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # runs programs without installing them
    nix-index-database.comma.enable = true;

    bottom.enable = true;
    bat.enable = true;
    fd.enable = true;
    htop.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
  };

  home = {
    stateVersion = "24.11";

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
      sshfs
      tlrc

      wget
    ];
  };
}
