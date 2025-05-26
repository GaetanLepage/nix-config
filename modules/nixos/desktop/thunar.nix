{
  flake.modules.nixos.thunar = {
    programs.thunar.enable = true;

    services = {
      # Mount, trash, and other functionalities
      gvfs.enable = true;

      # Thumbnail support for images
      tumbler.enable = true;
    };
  };
}
