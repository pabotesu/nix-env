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

  # Allow backlight control without sudo (including on ly login screen)
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
  '';

  # Handle backlight keys at system level (works on ly login screen)
  services.acpid = {
    enable = true;
    handlers = {
      brightnessDown = {
        event = "video/brightnessdown.*";
        action = "${pkgs.light}/bin/light -U 5";
      };
      brightnessUp = {
        event = "video/brightnessup.*";
        action = "${pkgs.light}/bin/light -A 5";
      };
    };
  };
}
