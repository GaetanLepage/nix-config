{
  flake.modules.homeManager.sway =
    { lib, pkgs, ... }:
    {
      wayland.windowManager.sway.config = {
        startup = [
          { command = "systemctl --user import-environment"; }
          {
            command = "${pkgs.writeShellScript "set-wallpaper" ''
              ${lib.getExe pkgs.killall} swaybg
              ${lib.getExe pkgs.swaybg} -m fill -i ${../wallpaper.png}
            ''}";
            always = true;
          }
          {
            command = lib.getExe pkgs.kanshi;
            always = true;
          }
          { command = "firefox"; }
          { command = "thunderbird"; }
          { command = lib.getExe pkgs.foot; }
        ];
      };
    };
}
