{
  config,
  pkgs,
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
    ./ssh.nix
    ./tmux.nix
    ./xdg.nix
    ./zellij.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
    comma # runs programs without installing them
    nix-index # used in conjunction with comma

    # Other utils
    ncdu
    sshfs

    git
    git-crypt

    pandoc
  ];

  ###########
  # Scripts #
  ###########
  # Add the scripts directory to PATH
  home.sessionPath = [
    (builtins.toString ../scripts)
  ];
}
