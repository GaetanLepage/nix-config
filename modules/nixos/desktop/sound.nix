{
  flake.modules.nixos.sound = {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
