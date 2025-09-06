{
  envTheme, 
  pkgs, 
  ...
}: {
  programs.zellij = {
      enable = true;
  };
  home.file = {
    "config_zellij" = {
        target = ".config/zellij/config.kdl";
        source = ./zellij_config.kdl.nix;
    };
    "theme_zellij" = {
       target = ".config/zellij/themes/custom_theme.kdl";
       text = ''
        themes {
          custom_theme {
            bg "${envTheme.bg}"
            fg "${envTheme.fg}"
            red "${envTheme.red}"
            green "${envTheme.green}"
            blue "${envTheme.blue}"
            yellow "${envTheme.yellow}"
            magenta "${envTheme.magenta}"
            cyan "${envTheme.cyan}"
            orange "${envTheme.orange}"
            black "${envTheme.black}"
            white "${envTheme.white}"
          }
        }
      '';
    };
  };
}
