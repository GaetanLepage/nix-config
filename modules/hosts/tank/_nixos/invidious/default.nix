{ config, pkgs, ... }:
{
  age.secrets.invidious-extra-settings = {
    rekeyFile = ./extra-settings.age;
    owner = "invidious";
    group = "invidious";
  };
  users = {
    users.invidious = {
      isSystemUser = true;
      group = "invidious";
    };
    groups.invidious = { };
  };

  services = {
    caddy.reverseProxies =
      let
        inherit (config.services.invidious)
          domain
          port
          ;
      in
      {
        ${domain}.port = port;
      };

    # Backup database automatically
    postgresqlBackup.enable = true;

    invidious = {
      enable = true;

      # package = (import inputs.nixpkgs {inherit (pkgs) system;}).invidious;

      domain = "invidious.glepage.com";
      port = 3000;

      sig-helper = {
        enable = true;

        # package = pkgs.inv-sig-helper.overrideAttrs (rec {
        #   src = pkgs.fetchFromGitHub {
        #     owner = "iv-org";
        #     repo = "inv_sig_helper";
        #     rev = "5d3c7a4574fafe0bc5fbed9e7e33483889832fd4";
        #     hash = "sha256-WGh62tjKGe9OD19aq+lP9GfYs5PrGqkeT6VvmtNottQ=";
        #   };
        #   cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
        #     inherit src;
        #     hash = "sha256-DnJL7kkcVn5dW3AoPCn829WmkaCjpDZtYUXnpiB857Q=";
        #   };
        # });
      };

      extraSettingsFile = config.age.secrets.invidious-extra-settings.path;

      settings = {
        # Allow/Forbid Invidious (local) account creation.
        # Invidious accounts allow users to subscribe to channels and to create playlists
        # without a Google account.
        registration_enabled = false;

        hmac_key = "ef9Shohh6hucuaK5thae";

        # Enable/Disable the "Popular" tab on the main page
        popular_enabled = false;

        db.user = "invidious";

        # Necessary settings when using a reverse proxy
        # https://docs.invidious.io/installation/#post-install-configuration
        https_only = true;
        external_port = 443;
        inherit (config.services.invidious) domain;
        use_pubsub_feeds = true;
        use_innertube_for_captions = true;

        default_user_preferences = {
          # List of feeds available on the home page.
          #
          # Note: "Subscriptions" and "Playlists" are only visible when the user is logged in.
          #
          # Accepted values: A list of strings
          # Each entry can be one of: "Popular", "Trending", "Subscriptions", "Playlists"
          #
          # Default: ["Popular", "Trending", "Subscriptions", "Playlists"]  (show all feeds)
          #
          feed_menu = [ "Trending" ];

          # Default feed to display on the home page.
          #
          # Note: setting this option to "Popular" has no effect when 'popular_enabled' is set
          # to false.
          #
          # Accepted values: Popular, Trending, Subscriptions, Playlists, <none>
          # Default: Popular
          #
          default_home = "Trending";

          # Default number of results to display per page.
          #
          # Note: this affects invidious-generated pages only, such as watch history and
          # subscription feeds.
          # Playlists, search results and channel videos depend on the data returned by the
          # Youtube API. (Default: 40)
          #
          max_results = 100;

          # Automatically play videos on page load. (Default: false)
          autoplay = false;
        };
      };
    };
  };
}
