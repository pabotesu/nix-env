{pkgs, ...}: {
  # Enable fingerprint reader
  services.fprintd.enable = true;

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  
  # Polkit authentication agent for 1Password
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

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
