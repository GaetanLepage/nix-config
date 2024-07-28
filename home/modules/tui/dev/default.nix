{pkgs, ...}: {
  imports = [
    ./apptainer.nix
    ./github-token.nix
    ./lua.nix
    ./nix
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

  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];
}
