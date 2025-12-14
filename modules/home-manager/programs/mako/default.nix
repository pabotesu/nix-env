{envTheme, pkgs, ...}: {
  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      font = "HackGen35 Console NFJ 11";
      border-radius = 10;
      border-size = 2;
      background-color = envTheme.bg;
      border-color = envTheme.fg;
      width = 400;
      height = 100;
    };
  };
  home.packages = with pkgs; [
    libnotify
  ];
} 
