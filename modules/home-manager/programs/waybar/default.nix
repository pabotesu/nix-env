{pkgs, ...}: {
  programs.waybar = {
    enable = true;
  };
  home.file.".config/waybar/config".source = ./waybar.config;
  home.file.".config/waybar/style.css".source = ./style.css;
}
