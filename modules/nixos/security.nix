{
  # Enable fingerprint reader
  services.fprintd.enable = true;

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  security = {
    polkit.enable = true;
    pam.services.login.enableGnomeKeyring = true;

    # wayland display lockers (e.g. swaylock) needs this
    pam.services.swaylock.text = "auth include login";
    
    # Enable fingerprint authentication
    pam.services.login.fprintAuth = true;
    pam.services.sudo.fprintAuth = true;
    pam.services.hyprlock.fprintAuth = true;
    pam.services.polkit-1.fprintAuth = true;
  };
}
