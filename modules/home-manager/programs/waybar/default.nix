{envTheme, pkgs, ...}: {
  programs.waybar = {
    enable = true;
  };
  home.file.".config/waybar/config".source = ./waybar.config;
  home.file.".config/waybar/style.css".text = ''
    /* Waybar Stylesheet */

    /* General Configuration */
    * {
        border: none;
        font-family: PlemolJP Console NF, Roboto Nerd, FiraCode Nerd Font;
        font-size: 15px;
      }
      
      window#waybar {
        background-color: rgba(40, 44, 52, 0.5);
        color: ${envTheme.fg};
        transition-property: background-color;
        transition-duration: 0.5s;
        padding: 0 3px;
      }
      
      window#waybar.hidden {
        opacity: 0.2;
      }
      
      #workspaces button {
        padding:5px 5px;
        color: ${envTheme.fg};
        border-radius: 5px;
        margin:5px 5px;
        padding: 0 3px;
      }
     
      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background: none;
        border: none;
      }
     
      #workspaces button.active {
        background-color: ${envTheme.blue};
        color: ${envTheme.bg};
        border-radius: 5px;
        margin:5px 5px;
      }

      #workspaces button.urgent {
        background-color: ${envTheme.red};
        color: ${envTheme.bg};
        margin:5px 5px;
        border-radius: 5px;
      }
      
      /* Modules Configuration */
      
      /* set default */
      
      #clock,
      #cpu,
      #network,
      #pulseaudio,
      #custom-pacman,
      #idle_inhibitor,
      #idle_inhibitor.activated,
      #tray,
      #mpd,
      #battery,
      #backlight,
      #memory,
      #temperature {
        margin: 2px 5px;
        padding: 3px 8px;
        border-radius: 3px;
      }
      
      #window,
      #workspaces,
      #custom-media {
        margin: 0 0px;
      }
      
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }
      
      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
      }
      
      #clock {
        font-size: 16px;
      }
      
      #window {
        padding: 0 25px;
      }
      
      
      #workspaces {
        padding: 0 0px;
      }

      #battery.charging {
        color: ${envTheme.green};
      }

      #battery.warning:not(.charging) {
        color: ${envTheme.yellow};
      }

      #battery.critical:not(.charging) {
        color: ${envTheme.red};
        animation: blink 1s linear infinite;
      }

      @keyframes blink {
        to {
          opacity: 0.5;
        }
      }

      #temperature.critical {
        color: ${envTheme.red};
      }
  '';
}
