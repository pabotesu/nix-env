{pkgs, ...}: {
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
          background-color: rgba(29, 31, 33, 0.95);
        }
        
        button {
          background-color: rgba(40, 44, 52, 0.8);
          border-radius: 10px;
          border: 2px solid rgba(197, 200, 198, 0.3);
          margin: 15px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
          color: #c5c8c6;
          font-size: 16px;
        }
        
        button:hover {
          background-color: rgba(60, 64, 72, 0.9);
          border: 2px solid rgba(197, 200, 198, 0.6);
        }
        
        button:focus {
          background-color: rgba(80, 84, 92, 1);
          border: 2px solid #c5c8c6;
        }
      '';
  };
}
