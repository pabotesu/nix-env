# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ 
  pkgs,
  outputs,
  userConfig,
  hostName,
  ...
}: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      
      ../../modules/nios/diplaymanager.nix
      ../../modules/nios/fonts.nix
      ../../modules/nios/i18n.nix
      ../../modules/nios/inputmethod.nix
      ../../modules/nios/networkmanager.nix
      ../../modules/nios/nix_options.nix
      ../../modules/nios/security.nix
      ../../modules/nixos/sound.nix
      ../../modules/nixos/windowmanager.nix
      ../../modules/nixos/xserver.nix

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
