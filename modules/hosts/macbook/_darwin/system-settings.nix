{ config, primaryUser, ... }:
{
  system = {
    defaults = {
      dock = {
        autohide = true;
        mru-spaces = false;

        # defaults write com.apple.dock expose-animation-duration -float 0.1
        expose-animation-duration = 0.1;

        # defaults write com.apple.dock autohide-time-modifier -float 0.1
        autohide-time-modifier = 0.1;
      };
      finder = {
        AppleShowAllExtensions = true;
        CreateDesktop = false;
        # column view
        FXPreferredViewStyle = "clmv";
      };
      screencapture.location =
        let
          picturesDir = config.home-manager.users.${primaryUser}.xdg.userDirs.pictures;
        in
        "${picturesDir}/screenshots";

      screensaver.askForPasswordDelay = 10;

      # universalaccess.reduceMotion = true;

      menuExtraClock.Show24Hour = true;

      NSGlobalDomain = {
        NSWindowResizeTime = 0.001;
        NSAutomaticWindowAnimationsEnabled = false;
        KeyRepeat = 1;
        InitialKeyRepeat = 20;
      };
    };

    keyboard = {
      enableKeyMapping = true;

      remapCapsLockToEscape = true;
      swapLeftCtrlAndFn = true;
    };
  };
}
