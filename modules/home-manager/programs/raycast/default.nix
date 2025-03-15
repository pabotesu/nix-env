{
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (pkgs.stdenv.isDarwin) {
    # install raycast only mac
    home.packages = with pkgs; [
      raycast
    ];
  };
}
