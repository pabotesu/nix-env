{envTheme, pkgs, ...}: {
  imports = [
    ./wlogout
  ];
  home.packages = with pkgs; [wofi wofi-emoji];
  home.file.".config/wofi/style.css".text = ''
    * {
      font-family: Nova Flat;
      font-size: 20;
    }

    window {
      margin: 0px;
      border: 4px solid ${envTheme.blue};
      background-color: ${envTheme.bg};
      border-radius: 5;
    }

    #input {
      margin: 5px;
      padding: 5px;
      border: none;
      color: ${envTheme.cyan};
      background-color: ${envTheme.black};
    }

    #inner-box {
      margin: 5px;
      border: none;
      background-color: ${envTheme.black};
    }

    #outer-box {
      margin: 5px;
      border: none;
      background-color: ${envTheme.bg};
    }

    #scroll {
      margin: 0px;
      border: none;
    }

    #text {
      margin: 15px;
      border: none;
      color: ${envTheme.cyan};
      font-size: 14px;
    }

    #entry {
      margin: 5px;
      background-color: ${envTheme.black};
      border: none; 
    }

    #entry:selected {
      background-color: ${envTheme.blue};
      border: none; 
      outline-style: none;
      color: ${envTheme.fg};
    }
  '';
}
