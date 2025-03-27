{ pkgs, ... }:
/*
  TODO
  - in fuzzy finder, use tab to cycle between entries
*/
{
  imports = [
    ./settings.nix
  ];
  programs = {
    zed-editor = {
      enable = true;

      extensions = [
        "git-firefly"
        "nix"
        "typst"
      ];

      extraPackages = with pkgs; [
        python3Packages.python-lsp-server
        tinymist
        nil
      ];

      installRemoteServer = true;

      userKeymaps = import ./keymaps.nix;
    };
  };
}
