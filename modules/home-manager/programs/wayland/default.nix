{envTheme, envColors, inputs, pkgs, config, ...}: {
  imports = [
    ./hyprpaper.nix
  ];

  home.packages = with pkgs; [
    # Wayland utility
    wtype
    wev
    wayvnc
    wob
    grimblast
    hyprpicker
    hyprcursor
    wl-clipboard
    brightnessctl
    pamixer
    playerctl
    feh
    clipman
    wdisplays
    wireplumber
    slurp
    # xwaylandvideobridge  # Removed: KDE Gear 5 and Plasma 5 have reached EOL
    copyq
    cliphist 
  ]
  ++ [
      inputs.hyprsome.packages.${pkgs.system}.default # workspace manager
    ];

  wayland = {
    windowManager.hyprland = {
      enable = true;
      extraConfig = import ./hyprland.config.nix {inherit envTheme envColors;};
    };
  };

}
