{
  flake.modules.nixos.android =
    { pkgs, primaryUser, ... }:
    {
      environment.systemPackages = with pkgs; [
        android-tools
        jmtpfs
      ];

      users.users.${primaryUser}.extraGroups = [ "adbusers" ];
    };
}
