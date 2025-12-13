{pkgs, ...}: {
  home.pointerCursor = 
    let 
      getFrom = url: hash: name: {
          gtk.enable = true;
          #x11.enable = true;
          name = name;
          size = 16;
          package = 
            pkgs.runCommand "moveUp" {} ''
              mkdir -p $out/share/icons
              ln -s ${pkgs.fetchzip {
                url = url;
                hash = hash;
              }} $out/share/icons/${name}
          '';
        };
    in
      getFrom 
        "https://github.com/ful1e5/XCursor-pro/releases/download/v2.0.1/XCursor-Pro-Dark.tar.gz"
        "sha256-wJ6rDCLwfOkGpYXVtfwTur8XHyu+WXk7XDhsroik5Os="
        "XCursor-Pro-Dark";

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Blue-Dark";
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # Qt dark theme
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  # Prefer dark theme
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Flat-Remix-GTK-Blue-Dark";
    };
  };
}
