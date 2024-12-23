{ pkgs, ... }:
{
  imports = [
    ./apptainer.nix # inria
    ./github-token.nix
    ./lua.nix
    ./nix.nix
    ./python.nix
    ./rust.nix
    ./shell.nix
    ./typst.nix
  ];

  programs.gh = {
    enable = true;

    settings = {
      git_protocol = "ssh";
    };
  };

  # inria
  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];
}
