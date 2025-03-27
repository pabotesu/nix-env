{
  description = "Nix Configuration For pabotesu";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # HomeManager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Darwin
    darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Utilities
    flake-utils.url = "github:numtide/flake-utils";

    # Homebrew
    #nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-homebrew.url = "git+https://github.com/zhaofengli/nix-homebrew?ref=refs/pull/71/merge";
  };

  outputs = { 
    self,
    darwin,
    home-manager,
    nix-homebrew,
    nixpkgs,
    nixpkgs-unstable,
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
          nix-homebrew.darwinModules.nix-homebrew
        ];
      };

    # Function for Home Manager configuration
    mkHomeConfiguration = system: username: hostname: theme:
      let
        pkgsUnstable = import inputs.nixpkgs-unstable { inherit system; };
      in
      home-manager.lib.homeManagerConfiguration {
        pkgs     = import nixpkgs {inherit system;};

        extraSpecialArgs = {
          inherit inputs outputs pkgsUnstable;
          userConfig = users.${username};
          nhModules = "${self}/modules/home-manager";
          envTheme = import ./themes/colors/${theme};
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
      "mac-machine" = mkDarwinConfiguration "mac-machine" "pabotesu";
    };

    homeConfigurations = {
      "pabotesu@mac-machine" = mkHomeConfiguration "aarch64-darwin" "pabotesu" "mac-machine" "onehalf";
      #"pabotesu@nix-machine" = mkHomeConfiguration "x86_64-linux" "pabotesu" "nix-machine" "onehalf";
    };

    overlays = import ./overlays {inherit inputs;};
  };
}
