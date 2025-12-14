{envTheme, pkgs, ...}: {
  programs.wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          action = "hyprlock";
          text = "Lock";
          keybind = "l";
        }
        {
          label = "logout";
          action = "hyprctl dispatch exit";
          text = "Exit";
          keybind = "e";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Suspend";
          keybind = "u";
        }
      ];
      style = ''
        * {
          background-image: none;
          box-shadow: none;
        }
        
        window {
          background-color: rgba(40, 44, 52, 0.9);
        }
        
        button {
          border-radius: 10px;
          border-color: ${envTheme.black};
          text-decoration-color: ${envTheme.fg};
          color: ${envTheme.fg};
          background-color: ${envTheme.bg};
          border-style: solid;
          border-width: 3px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 40%;
          margin: 15px;
          min-width: 150px;
          min-height: 150px;
        }
        
        button:focus, button:active, button:hover {
          background-color: ${envTheme.fg};
          color: ${envTheme.bg};
          border-color: ${envTheme.cyan};
          outline-style: none;
        }
        
        #lock {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/lock.png");
        }
        
        #logout {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/logout.png");
        }
        
        #shutdown {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png");
        }
        
        #reboot {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/reboot.png");
        }
        
        #suspend {
          background-image: url("${pkgs.wlogout}/share/wlogout/icons/suspend.png");
        }
      '';
  };
}
