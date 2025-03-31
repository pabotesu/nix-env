# My environment built with Nix

## 🚀 install Nix
### For macOS

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```
> [!IMPORTANT]
>
>--determinate is not used because it conflicts with nix-darwin.
>Also, choose No when asked "Install Determinate Nix?"

## ✍️ Usage

### Adding a New Machine with a New User
To add a new machine with a new user to your NixOS or nix-darwin configuration, follow these steps:

1. Update flake.nix
    1. Add the new user to the users attribute set:
        ```nix
            # Define user configurations
            users = {
                pabotesu = {
                    email = "newuser@example.com";
                    fullName = "New User";
                    name = "newuser";
                };
            };
        ```
    2. Add the new machine to the appropriate configuration set:

        🍎 For macOS(nix-darwin)
        ```nix
        darwinConfigurations = {
        # Existing configurations...
        newmachine = mkDarwinConfiguration "newmachine" "newuser";
        };
        ```
    
    3. Add the new home configuration:

        ```nix
        homeConfigurations = {
        # Existing configurations...
        "newuser@newmachine" = mkHomeConfiguration "x86_64-linux" "newuser" "newmachine";
        };
        ```
2. Create System Configuration:

    1. Create a new directory under hosts/ for your machine:

        ```sh
        mkdir -p hosts/newmachine
        ```
    2. Create default.nix in this directory:

        ```sh
        touch hosts/newmachine/default.nix
        ```
    3. Add the basic configuration to default.nix:

        ```nix
        { config, pkgs, more_your_elements... }:
        {
        # Add machine-specific configurations here
        }
        ```

3. Create Home Manager Configuration:

    1. Create a new directory for the user's host-specific configuration:

        ```sh
        mkdir -p home/newuser/newmachine
        touch home/newuser/newmachine/default.nix
        ```
    
    2. Add basic home configuration:

        ```nix
        { nhModules, ... }:
        {
            imports = [
                "${nhModules}/common"
                # and more ...
            ];
        }
        ```

4. Building and Applying Configurations:

    1. add new files

        ```sh
        git add .
        ```

    2. Build and switch to the new system configuration:

        🍎 For macOS(nix-darwin)
        ```sh
        darwin-rebuild switch --flake .#newmachine
        ```
        > [!TIP]
        > If First Run darwin-rebuild
        > ```
        > nix run nix-darwin/master#darwin-rebuild -- switch --flake .#newmachine
        > ```

    3. Build and switch to the new Home Manager configuration:

        ```
        home-manager switch --flake ./#newuser@newmachine
        ```
        > [!TPP]
        > If First Run home-manager
        > ```
        > nix run home-manager -- switch --flake "./#newuser@newmachine"
        > ```

## Updating Flakes

To update all flake inputs to their latest versions:
```sh
nix flake update
```
and rebuild ...
