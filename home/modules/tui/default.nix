{pkgs, ...}: {
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
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # runs programs without installing them
    nix-index-database.comma.enable = true;
  };

  home.packages = with pkgs; [
    # Rust implementations of linux commands
    bat # cat
    bottom # System monitor
    du-dust # du
    dua # du
    fd # find
    lfs # df
    procs # ps
    ripgrep

    # Other utils
    ncdu
    sshfs

    git
  ];
}
