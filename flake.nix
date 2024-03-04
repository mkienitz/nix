{
  description = "Nix configurations for all machines";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bipper = {
      url = "github:mkienitz/bipper-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    coffee-labeler = {
      url = "github:mkienitz/coffee-labeler";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    agenix-rekey,
    darwin,
    devshell,
    flake-utils,
    nixpkgs,
    pre-commit-hooks,
    self,
    ...
  } @ inputs:
    {
      agenix-rekey = agenix-rekey.configure {
        userFlake = self;
        nodes = {inherit (self.nixosConfigurations) hygiea iapetus;};
      };

      # Tim Apple
      darwinConfigurations.io = darwin.lib.darwinSystem {
        pkgs = self.pkgs.aarch64-darwin;
        specialArgs = {inherit inputs;};
        modules = [./hosts/io];
      };

      # Not Tim Apple
      nixosConfigurations = let
        mkNixosHost = hostname: arch:
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
              inherit (self.pkgs.${arch}) lib;
            };
            modules = [
              ./hosts/${hostname}
              {
                nixpkgs = {
                  hostPlatform = arch;
                  inherit (self.pkgs.${arch}) overlays config;
                };
              }
            ];
          };
      in {
        # Hetzner vServer
        gonggong = mkNixosHost "gonggong" "aarch64-linux";
        # Raspberry Pi 4
        hygiea = mkNixosHost "hygiea" "aarch64-linux";
        # Beelink Mini S12 Pro
        iapetus = mkNixosHost "iapetus" "x86_64-linux";
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system: rec {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            agenix-rekey.overlays.default
            devshell.overlays.default
            (_final: prev: {
              deploy = prev.callPackage (pkgs.fetchFromGitHub
                {
                  owner = "oddlama";
                  repo = "nix-config";
                  rev = "124e1c289f39e0f43b249d361a56286d3b6d87d6";
                  hash = "sha256-7+EnNwttjsUGVrI+pT9OWcoJU7Nx0lpOcy0k9A1zZdY=";
                }
                + "/pkgs/deploy.nix") {};
            })
          ];
        };

        # nix flake check
        checks.pre-commit-hooks = pre-commit-hooks.lib.${system}.run {
          src = pkgs.lib.cleanSource ./.;
          hooks = {
            alejandra.enable = true;
            deadnix.enable = true;
            statix.enable = true;
          };
        };

        # nix fmt
        formatter = pkgs.alejandra;

        # nix develop
        devShells.default = pkgs.devshell.mkShell {
          packages = with pkgs; [
            age-plugin-yubikey
            nil
          ];

          devshell.startup.pre-commit.text = checks.pre-commit-hooks.shellHook;

          commands = with pkgs; [
            {
              name = "rekey";
              help = "run agenix rekey and copy to remote builders";
              command = ''
                agenix rekey && \
                agenix rekey --show-out-paths | xargs nix copy --to ssh://gonggong
              '';
              category = "deployment";
            }
            {
              package = deploy;
              help = "deploy config to host";
              category = "deployment";
            }
            {
              package = deadnix;
              help = "scan nix files for dead code";
              category = "lint";
            }
            {
              package = statix;
              help = "lint nix files";
              category = "lint";
            }
            {
              package = pkgs.agenix-rekey;
              help = "create and edit secrets";
              category = "other";
            }
            {
              package = nix-tree;
              help = "browse dependency graph of derivations";
              category = "other";
            }
          ];
        };
      }
    );
}
