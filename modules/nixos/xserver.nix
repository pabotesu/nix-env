{

  # DisplayLink USB dock support
  # setting "displaylink" in videoDrivers triggers nixos/modules/hardware/video/displaylink.nix
  # which auto-enables: evdi kernel module, dlm systemd service, udev rules, and X11 config
  services.xserver = {
    enable = true;
    videoDrivers = [ "displaylink" "modesetting" ];
    autoRepeatDelay = 300;
    autoRepeatInterval = 30;
  };
  services.libinput = {
      enable = true;
      mouse.accelProfile = "flat";
  };
}
