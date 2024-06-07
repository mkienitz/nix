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
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
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
      inputs.flake-utils.follows = "flake-utils";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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
        nodes = builtins.removeAttrs self.nixosConfigurations ["gonggong"];
      };

      # Tim Apple
      darwinConfigurations.io = darwin.lib.darwinSystem {
        pkgs = self.pkgs.aarch64-darwin;
        specialArgs = {inherit inputs;};
        modules = [./hosts/io];
      };

      # Not Tim Apple
      nixosConfigurations = let
        mkNixosHost = import ./lib/mkNixosHost.nix inputs;
      in {
        # Hetzner vServer
        gonggong = mkNixosHost "gonggong" "aarch64-linux";
        # Raspberry Pi 4
        hygiea = mkNixosHost "hygiea" "aarch64-linux";
        # Beelink Mini S12 Pro
        iapetus = mkNixosHost "iapetus" "x86_64-linux";
        # Desktop
        phoebe = mkNixosHost "phoebe" "x86_64-linux";
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system: rec {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            agenix-rekey.overlays.default
            devshell.overlays.default
            (import ./pkgs/deploy.nix)
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

          commands = [
            {
              name = "rekey";
              help = "run agenix rekey and copy to specified remote builder";
              command = ''
                agenix rekey 2>/dev/null && \
                agenix rekey --show-out-paths 2>/dev/null | tail -n +2 | xargs nix copy --to "ssh://''${1}"
              '';
              category = "deployment";
            }
            {
              package = pkgs.deploy;
              help = "deploy config to host";
              category = "deployment";
            }
            {
              package = pkgs.deadnix;
              help = "scan nix files for dead code";
              category = "lint";
            }
            {
              package = pkgs.statix;
              help = "lint nix files";
              category = "lint";
            }
            {
              package = pkgs.agenix-rekey;
              help = "create and edit secrets";
              category = "other";
            }
            {
              package = pkgs.nix-tree;
              help = "browse dependency graph of derivations";
              category = "other";
            }
          ];
        };
      }
    );
}
