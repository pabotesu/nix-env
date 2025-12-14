{pkgs, ...}: {
  home.packages = with pkgs; [
    _1password-gui
    _1password
    # age # 将来的に秘密管理用に追加予定
  ];
}
