{
  outputs,
  userConfig,
  envTheme,
  pkgs,
  pkgsUnstable,
  ...
}: {
  imports = [
    ../programs/terminal
    ../programs/social-media
    ../programs/git
    ../programs/web-browser
    ../programs/wofi
    ../programs/hyperlock
    ../programs/waybar
    ../programs/shell
    ../programs/vpn
    ../programs/editor
    ../programs/mako ## notification daemon
    ../programs/gtk
    ../programs/xdg
    ../programs/mako
    ../programs/wayland
    ../programs/inputmethod
    ../programs/network-manager
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
    homeDirectory = "/home/${userConfig.name}";
  };
}
