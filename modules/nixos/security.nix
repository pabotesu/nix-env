{pkgs, ...}: {
  # Enable fingerprint reader
  services.fprintd = {
    enable = true;
  };

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
    
    # Enable fingerprint authentication with password fallback and shorter timeout
    # Custom PAM configuration with 5 second timeout for fingerprint
    pam.services.sudo.text = ''
      # Account management
      account required pam_unix.so
      
      # Authentication - fingerprint with 5 second timeout, then password
      auth sufficient pam_fprintd.so timeout=5
      auth sufficient pam_unix.so try_first_pass likeauth nullok
      auth required pam_deny.so
      
      # Password management
      password sufficient pam_unix.so nullok yescrypt
      
      # Session management
      session required pam_env.so conffile=/etc/pam/environment readenv=0
      session required pam_unix.so
      session required pam_limits.so
    '';
    
    pam.services.polkit-1.text = ''
      # Account management
      account required pam_unix.so
      
      # Authentication - fingerprint with 5 second timeout, then password
      auth sufficient pam_fprintd.so timeout=5
      auth sufficient pam_unix.so try_first_pass likeauth nullok
      auth required pam_deny.so
    '';
    
    # For login and hyprlock, use fprintAuth (default timeout is acceptable for these)
    pam.services.login.fprintAuth = true;
    pam.services.hyprlock.fprintAuth = true;
  };
}
