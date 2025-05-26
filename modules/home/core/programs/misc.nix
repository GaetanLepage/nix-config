{
  flake.modules.homeManager.core =
    { pkgs, ... }:
    {
      programs = {
        bat.enable = true;
        fd.enable = true;
        jq.enable = true;
        ripgrep.enable = true;
      };

      home = {
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
    };
}
