let
  substituters = [
    {
      url = "https://cache.nixos.org";
      publicKey = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
      priority = 1;
    }
    {
      url = "https://nix-community.cachix.org";
      publicKey = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
      priority = 2;
    }
    {
      url = "https://cache.glepage.com";
      publicKey = "cache.glepage.com:iaI4fkpeSy8sg8u5M8KnMsl4mSS1vwMYWj+ipqz9ugg=";
      priority = 3;
    }
    {
      url = "https://cache.jonringer.us";
      publicKey = "cache.jonringer.us:BZogIwFAp94LYcmaOi6xkHGJeRhMcQtFO8l6AmJNsng=";
      priority = 4;
    }
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
