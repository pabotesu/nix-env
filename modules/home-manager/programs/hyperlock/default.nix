{envTheme,
  pkgs,
  ...
}: {
  home.packages  =with pkgs;[
    hyprlock
    hypridle
  ];
  home.file.".config/hypr/hyprlock.conf".text = ''
    $text_color = ${envTheme.fg}
    $entry_background_color = ${envTheme.black}11
    $entry_border_color = ${envTheme.blue}55
    $entry_color = ${envTheme.fg}
    $font_family = PlemolJP Console NF
    $font_family_clock = PlemolJP Console NF
    $font_material_symbols = PlemolJP Console NF

    background {
        color = ${envTheme.bg}
        # path = {{ SWWW_WALL }}
        path = screenshot
        blur_size = 5
        blur_passes = 4
    }
    input-field {
        monitor =
        size = 250, 50
        outline_thickness = 2
        dots_size = 0.1
        dots_spacing = 0.3
        outer_color = $entry_border_color
        inner_color = $entry_background_color
        font_color = $entry_color
        # fade_on_empty = true

        position = 0, 20
        halign = center
        valign = center
    }

    label { # Clock
        monitor =
        text = $TIME
        shadow_passes = 1
        shadow_boost = 0.5
        color = $text_color
        font_size = 160
        font_family = $font_family_clock

        position = 0, 300
        halign = center
        valign = center
    }
    label { # lock icon
        monitor =
        text =  ""
        shadow_passes = 1
        shadow_boost = 0.5
        color = $text_color
        font_size = 25
        font_family = $font_material_symbols

        position = 0, 65
        halign = center
        valign = bottom
    }
  '';
  home.file.".config/hypr/hypridle.conf".source = ./hypridle.config; 
}
