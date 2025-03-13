{pkgs, ...}: {
  # Install ghostty
  home.packages = with pkgs; [
      ghostty
  ];
  home.file = {
    "config" = {
      target = ".config/ghostty/config";
      source = ./config.nix;
    };
  };
};
