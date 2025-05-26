{
  flake.modules.nixos.android =
    { pkgs, ... }:
    {
      programs.adb.enable = true;

      environment.systemPackages = with pkgs; [
        jmtpfs
      ];

      users.users.gaetan.extraGroups = [ "adbusers" ];
    };
}
