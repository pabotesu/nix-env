{
  pkgs,
  outputs,
  userConfig,
  ...
}: {

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  # Homebrew configuration
  nix-homebrew = {
     enable = true;
     enableRosetta = true;
     user = "${userConfig.name}";
     autoMigrate = true;
  };

  homebrew = {
     enable = true;
     brews = [
      {
        name = "autoraise";
        args = ["with-dalternative_task_switcher"];
        restart_service = "changed";
        start_service = true;
	    }
      "borders"
      "mas"
     ];
     casks = [
      "1password"
      "desktoppr"
      "tailscale"
      "microsoft-remote-desktop"
      "chatgpt"
      "wireshark"
     ];
     masApps = {
      "kindle" = 302584613;
     };
     taps = [
       "nikitabobko/tap"
       "dimentium/autoraise"
       "FelixKratz/formulae"
     ];
     onActivation.cleanup = "zap";
   };

  # Nix settings
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    optimise.automatic = true;
    package = pkgs.nix;
  };

  # User configuration
  users.users.${userConfig.name} = {
    name = "${userConfig.name}";
    home = "/Users/${userConfig.name}";
  };

  # System settings
  system = {
    primaryUser = userConfig.name;
    defaults = {
      CustomUserPreferences = {
        NSGlobalDomain."com.apple.mouse.linear" = true;
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            # Disable 'Cmd + Space' for Spotlight Search
            "64" = {
              enabled = false;
            };
            # Disable 'Cmd + Alt + Space' for Finder search window
            "65" = {
              enabled = false;
            };
          };
        };
      };
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode = true;
        PMPrintingExpandedStateForPrint = true;
      };
      LaunchServices = {
        LSQuarantine = false;
      };
      trackpad = {
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
        Clicking = true;
      };
      finder = {
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
        _FXSortFoldersFirst = true;
      };
      dock = {
        autohide = true;
        expose-animation-duration = 0.15;
        show-recents = false;
        showhidden = true;
        persistent-apps = [];
        persistent-others = [];
        tilesize = 30;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
      };
      screencapture = {
        location = "/Users/${userConfig.name}/Pictures/screenshots";
        type = "png";
        disable-shadow = true;
      };
    };
    keyboard = {
      remapCapsLockToControl = true;
      enableKeyMapping = true;
      # Remap §± to ~
      #userKeyMapping = [
        #{
          #HIDKeyboardModifierMappingDst = 30064771125;
          #HIDKeyboardModifierMappingSrc = 30064771172;
        #}
      #];
    };
    # The settings will be forcibly reflected without the need to reboot the device.
    activationScripts.activateSettings.text = ''
      # Following line should allow us to avoid a logout/login cycle when changing settings
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      /usr/local/bin/desktoppr /Users/pabotesu/Library/wallpaper.png
    '';
  };

  # Zsh configuration
  programs.zsh.enable = true;

  # Fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];
  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;
}
