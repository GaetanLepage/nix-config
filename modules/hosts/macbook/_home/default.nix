{
  imports = [
    ./ghostty.nix
    ./mistral-deps.nix
    ./ssh
    ./vibe.nix
  ];

  targets.darwin.defaults.NSGlobalDomain.AppleLocale = "en_US";
  home.sessionVariables =
    let
      locale = "en_US.UTF-8";
    in
    {
      LC_ALL = locale;
      LANG = locale;
      LANGUAGE = locale;
    };
}
