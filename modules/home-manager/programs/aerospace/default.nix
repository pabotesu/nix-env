{
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (pkgs.stdenv.isDarwin) {
    # Ensure aerospace package installed
    home.packages = with pkgs; [
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
