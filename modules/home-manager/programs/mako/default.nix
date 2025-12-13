{envTheme, pkgs, ...}: {
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    font = "HackGen35 Console NFJ";
    borderRadius = 10;
    borderSize = 2;
    backgroundColor = envTheme.bg;
    borderColor = envTheme.fg;
    width = 400;
    height = 100;
  };
  home.packages = with pkgs; [
    libnotify
  ];
} 
