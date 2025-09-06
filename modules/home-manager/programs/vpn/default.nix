{
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (pkgs.stdenv.isDarwin) {
    # Ensure aerospace package installed
    home.packages = with pkgs; [
      ## tailscale
      tailscale
      tailscalesd
      ## wireguard
      wireguard-tools
    ];
  };
}
