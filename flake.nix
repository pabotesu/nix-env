{
  description = "Nix Configuration For pabotesu";

  inputs = {

    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # HomeManager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Darwin
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # Utilities
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { 
    self,
    darwin,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Define user configurations
    users = {
      pabotesu = {
        avatar = ./files/avatar/pabotesu;
        email = "contact@mail.pabotesu.com";
        fullName = "Lee Tesu";
        #gitKey = "C5810093";
        name = "pabotesu";
      };
    };

    # Function for NixOS system configuration
    mkNixosConfiguration = hostname: username:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
          nixosModules = "${self}/modules/nixos";
        };
        modules = [./hosts/${hostname}];
      };

    # Function for nix-darwin system configuration
    mkDarwinConfiguration = hostname: username:
      darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
        };
        modules = [
          ./hosts/${hostname}
          home-manager.darwinModules.home-manager
        ];
      };

    # Function for Home Manager configuration
    mkHomeConfiguration = system: username: hostname: theme:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {inherit system;};
        extraSpecialArgs = {
          inherit inputs outputs;
          userConfig = users.${username};
          nhModules = "${self}/modules/home-manager";
          envTheme = ""${self}/themes/${theme}"
        };
        modules = [
          ./home/${username}/${hostname}
        ];
      };
  in {
    nixosConfigurations = {
      nix-machine = mkNixosConfiguration "nix-machine" "nabokikh";
    };

    darwinConfigurations = {
      "mac-machine" = mkDarwinConfiguration "pabotesu-macmini" "pabotesu";
    };

    homeConfigurations = {
      "nabokikh@macmini" = mkHomeConfiguration "aarch64-darwin" "pabotesu" "mac-machine" "oneharf";
      # "pabotesu@nix-machine" = mkHomeConfiguration "x86_64-linux" "pabotesu" "nix-machine" "oneharf";
    };

    overlays = import ./overlays {inherit inputs;};
  };
}
