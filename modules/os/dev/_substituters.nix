let
  substituters = [
    {
      url = "https://cache.nixos.org";
      publicKey = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
      priority = 1;
    }
    {
      url = "https://nix-cache.ynh.ovh";
      publicKey = "nix-cache.ynh.ovh:9qrjMrCm2hFYIuEgexkBxJTG0/6kT2jqd8muFtUezbk=";
      priority = 2;
    }
    {
      url = "https://nix-community.cachix.org";
      publicKey = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
      priority = 3;
    }
    {
      url = "https://cache.flox.dev";
      publicKey = "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs=";
      priority = 4;
    }
    {
      url = "https://cache.nixos-cuda.org";
      publicKey = "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=";
      priority = 5;
    }
    # {
    #   url = "https://cache.jonringer.us";
    #   publicKey = "cache.jonringer.us:BZogIwFAp94LYcmaOi6xkHGJeRhMcQtFO8l6AmJNsng=";
    #   priority = 5;
    # }
  ];
in
{
  flake.modules.nixos.substituters = {
    nix.settings = {
      trusted-public-keys = builtins.catAttrs "publicKey" substituters;

      substituters = builtins.map (def: "${def.url}?priority=${toString def.priority}") substituters;
    };
  };
}
