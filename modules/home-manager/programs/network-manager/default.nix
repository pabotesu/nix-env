{pkgs, ...}: {
  home.packages = with pkgs; [
    networkmanagerapplet # nm-applet for WiFi management
  ];
}
