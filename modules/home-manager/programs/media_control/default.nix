{
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (pkgs.stdenv.isDarwin) {
    home.packages = [];
  };
}
