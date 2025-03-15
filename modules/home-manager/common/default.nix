{
  outputs,
  userConfig,
  envTheme,
  pkgs,
  ...
}: {
  imports = [
    ../programs/aerospace
    ../programs/alacritty
    ../programs/git
    ../programs/google-chrome
    ../programs/raycast
    ../programs/shell
    ../programs/vscode
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
  };
}
