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
    ./lf.nix
    ./neovim
    ./nix.nix
    ./shell
    ./ssh
    ./tmux.nix
    ./xdg.nix
    ./zellij.nix
    inputs.nix-index-database.hmModules.nix-index
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # runs programs without installing them
    nix-index-database.comma.enable = true;
  };

  home = {
    stateVersion = "24.11";

    username = lib.mkDefault "gaetan";
    homeDirectory = lib.mkDefault "/home/gaetan";

    packages = with pkgs; [
      # Rust implementations of linux commands
      bat # cat
      bottom # System monitor
      du-dust # du
      dua # du
      fd # find
      dysk # df
      procs # ps
      ripgrep

      # Other utils
      htop
      ncdu
      sshfs
      tlrc

      git
      wget
    ];
  };
}
