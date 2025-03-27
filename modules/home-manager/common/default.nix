{
  outputs,
  userConfig,
  envTheme,
  pkgs,
  pkgsUnstable,
  ...
}: {
  imports = [
    ../programs/aerospace
    ../programs/alacritty
    ../programs/arc-browser
    ../programs/discord
    ../programs/git
    ../programs/google-chrome
    ../programs/raycast
    ../programs/shell
    ../programs/vscode
    ../programs/zellij
  ];

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  # Home-Manager configuration for the user's home environment
  home = {
    username = "${userConfig.name}";
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/${userConfig.name}"
      else "/home/${userConfig.name}";
    file.".ssh/config".source = ./ssh.config;
    file = {
      "wallpaper.jpg" = {
        target = "Library/wallpaper.png";
        source = pkgs.fetchurl {
          url = "https://r4.wallpaperflare.com/wallpaper/97/833/155/mountains-firewatch-green-forest-wallpaper-5c0e3259b4dddc065048fc083c336564.jpg";
          sha256 = "sha256-EbzHAqSPD9bR9suBzJVxPEmPLhBmfnaX6cNBucRiBv8=";
        };
      };
    };
  };
}
