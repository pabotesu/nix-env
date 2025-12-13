# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ 
  config,
  pkgs,
  outputs,
  userConfig,
  hostName,
  nixosModules,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    "${nixosModules}/nix_options.nix"
    "${nixosModules}/fonts.nix"
    "${nixosModules}/i18n.nix"
    "${nixosModules}/inputmethod.nix"
    "${nixosModules}/network.nix"
    "${nixosModules}/security.nix"
    "${nixosModules}/sound.nix"
    "${nixosModules}/windowmanager.nix"
    "${nixosModules}/xserver.nix"
    "${nixosModules}/displaymanager.nix"
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };

  networking.hostName = hostName; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userConfig.name} = {
    isNormalUser = true;
    description = userConfig.name;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   vim
   wget
   git
   bottom
   killall
  ];

  # enable ssh
  services.openssh.enable = true; 

  # Did you read the comment?
  system.stateVersion = "25.11";
}
