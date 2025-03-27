{
  envTheme, 
  pkgs, 
  ...
}: {
  # Install alacritty via home-manager moduleo
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        live_config_reload = true;
      };
      terminal = {
        shell = {
          program = "zsh";
          args = ["-l"  "-c"  "zellij attach --index 0 --create"];
        };
      };

      window = {
        decorations =
          if pkgs.stdenv.isDarwin
          then "buttonless"
          else "none";
        dynamic_title = false;
        dynamic_padding = true;
        dimensions = {
          columns = 170;
          lines = 45;
        };
        padding = {
          x = 10;
          y = 10;
        }; 
        opacity = 0.8;
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      font = {
        size =
          if pkgs.stdenv.isDarwin
          then 15
          else 12;
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
      };

      selection = {
        semantic_escape_chars = '',│`|:"' ()[]{}<>'';
        save_to_clipboard = true;
      };

      colors = {
          primary = {
            background = envTheme.bg;
            foreground = envTheme.fg;
          };
          normal = {
            inherit (envTheme) black;
            inherit (envTheme) red;
            inherit (envTheme) green;
            inherit (envTheme) yellow;
            inherit (envTheme) blue;
            inherit (envTheme) magenta;
            inherit (envTheme) cyan;
            inherit (envTheme) white;
          };
        };
    };
  };
}
