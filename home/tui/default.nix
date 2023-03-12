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
  xdg.configFile.scripts.source = ../scripts;
  # Add the scripts directory to PATH
  # install_dotfiles.sh script
  home.sessionPath = [
    "${config.home.homeDirectory}/${config.xdg.configFile.scripts.target}"
  ];
}
