{ config, pkgs, lib, ... }:

let
  # 壁紙URLを指定（変更するだけで自動ダウンロード）
  wallpaperUrl = "https://c.l3n.co/P9zOPz.png";
  
  # インターネットから壁紙を自動ダウンロード
  wallpaperImage = pkgs.fetchurl {
    url = wallpaperUrl;
    # sha256ハッシュは以下のコマンドで取得:
    # nix-prefetch-url <URL>
    sha256 = "0gqrcvnnvanf7cpn37ldqf47rbn05xxy6y1sqvzrm7gby47gi85h";
  };
in
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  # hyprpaper設定ファイル
  home.file.".config/hypr/hyprpaper.conf".text = ''
    # Nix storeから直接壁紙を読み込み
    preload = ${wallpaperImage}

    # 全モニターに同じ壁紙を適用
    wallpaper {
      monitor =
      path = ${wallpaperImage}
    }

    # 個別設定する場合はこちら
    # wallpaper {
    #   monitor = eDP-1
    #   path = ${wallpaperImage}
    # }
    # wallpaper {
    #   monitor = DP-1
    #   path = ${wallpaperImage}
    # }
    # wallpaper {
    #   monitor = DP-2
    #   path = ${wallpaperImage}
    # }
    
    # スプラッシュ画面を無効化（起動速度向上）
    splash = false
  '';
}
