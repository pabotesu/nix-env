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
        window {
          background-color: ${envTheme.bg}ee;
        }
        
        button {
          background-color: ${envTheme.bg};
          border-radius: 10px;
          border: 2px solid ${envTheme.fg}4d;
          margin: 15px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 40%;
          color: ${envTheme.fg};
          font-size: 16px;
          min-width: 150px;
          min-height: 150px;
        }
        
        button:hover {
          background-color: ${envTheme.blue}33;
          border: 2px solid ${envTheme.blue};
        }
        
        button:focus, button:active {
          background-color: ${envTheme.fg};
          border: 3px solid ${envTheme.blue};
          color: ${envTheme.bg};
          outline: 2px solid ${envTheme.green};
          outline-offset: 2px;
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
