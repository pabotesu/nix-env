{pkgs, ...}: {
  home.packages = with pkgs; [
    wdisplays  # Wayland display configuration GUI
  ];
}
