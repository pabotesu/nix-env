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
    "${nixosModules}/bluetooth.nix"
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userConfig.name} = {
    isNormalUser = true;
    description = userConfig.name;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" ];
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

  # Enable zsh
  programs.zsh.enable = true;

  # Enable 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "${userConfig.name}" ];
  };

  # Did you read the comment?
  system.stateVersion = "25.11";
}
