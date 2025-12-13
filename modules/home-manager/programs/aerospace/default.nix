{
  lib,
  pkgs,
  pkgsUnstable,
  ...
}: {
  config = lib.mkIf (pkgsUnstable.stdenv.isDarwin) {
    # Ensure aerospace package installed
    home.packages = with pkgsUnstable; [
      aerospace
    ];
    # Source aerospace config from the home-manager store
    home.file = {
      "config_aerospace" = {
        target = ".aerospace.toml";
        source = ./aerospace.toml.nix;
      };
    };
  };
}
