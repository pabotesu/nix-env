{pkgs, ...}: {
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    # Bluetooth audio support
    wireplumber.enable = true;
  };

  # Enable Bluetooth audio codecs
  environment.systemPackages = with pkgs; [
   pavucontrol
   pamixer
  ];

  programs.noisetorch.enable = true;
}
