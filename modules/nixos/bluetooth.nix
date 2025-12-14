{ config, lib, pkgs, ... }:
{
  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Enable Blueman for Bluetooth management
  services.blueman.enable = true;
}
