{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.hyprpaper.homeManagerModules.default
  ];

  config = {
    services.hyprpaper = {
      enable = true;

      preloads = [config.wallpaper];
      wallpapers = [", ${config.wallpaper}"];
      ipc = false;
    };
  };
}
