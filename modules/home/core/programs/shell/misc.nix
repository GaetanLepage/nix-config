{
  flake.modules.homeManager.core = {
    programs = {
      zoxide = {
        enable = true;
        options = [
          "--cmd"
          "j"
        ];
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      fzf.enable = true;
    };
  };
}
