{ config, lib, pkgs, ... }:
{
  # Ensure greetd is not enabled anywhere by default (hosts can override if needed)
  services.greetd.enable = lib.mkDefault false;

  # Enable ly globally with the Matrix animation
  # Animations  "doom", "colormix", "matrix"
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
    };
  };

  # Enable backlight control
  programs.light.enable = true;

  # Allow backlight control without sudo
  # Ly uses brightnessctl internally for backlight control
  services.udev.extraRules = ''
    SUBSYSTEM=="backlight", ACTION=="add", KERNEL=="*", RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/class/backlight/%k/brightness"
  '';

  # Ensure brightnessctl is available system-wide for ly
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}
