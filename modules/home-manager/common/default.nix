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
    ../programs/tailscale
    ../programs/vscode
    ../programs/wireguard
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
          url = "https://r4.wallpaperflare.com/wallpaper/434/309/126/minimalism-cat-funny-digital-art-artwork-hd-wallpaper-3ffcc20f4d49c558678db28474936070.jpg";
          sha256 = "sha256-4cIk4Drc0Q/CNSwJiTGVPd4npeV+dtIomONGRrTaWuo=";
        };
      };
    };
  };
}
