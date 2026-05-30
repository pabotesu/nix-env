{
  outputs,
  userConfig,
  envTheme,
  pkgs,
  ...
}: {
  imports = [
    ../programs/aerospace
    ../programs/terminal
    ../programs/social-media
    ../programs/git
    ../programs/web-browser
    ../programs/raycast
    ../programs/shell
    ../programs/vpn
    ../programs/editor
    ../programs/media_control
  ];

  nixpkgs.config.allowUnfree = true;
  home.enableNixpkgsReleaseCheck = false;

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
          url = "https://i.imgur.com/p6qt9aE.jpeg";
          sha256 = "sha256-CXeMJvv4WfJQ/IvNS3z944X9Jv70lQZdHPjRXVUhR40=";
        };
      };
    };
  };
}
