{pkgs, lib, ...}: {
  home.packages = with pkgs; 
    # 1Password is managed via NixOS module (programs._1password-gui)
    # lib.optionals pkgs.stdenv.isLinux [
    #   _1password-gui
    #   _1password-cli
    # ] ++
    [
      # age # 将来的に秘密管理用に追加予定（Linux/Darwin両方）
    ];
}
