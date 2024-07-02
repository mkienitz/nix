{
  description = "Nix configurations for all machines";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
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
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-templates = {
      url = "github:mkienitz/nix-templates";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.devshell.follows = "devshell";
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
    flake-parts,
    nixpkgs,
    pre-commit-hooks,
    self,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;}
    ({withSystem, ...}: {
      systems = [
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-linux"
        "x86_64-darwin"
      ];

      imports = [
        inputs.devshell.flakeModule
        inputs.agenix-rekey.flakeModule
      ];

      flake = {
        # Tim Apple
        darwinConfigurations.io = withSystem "aarch64-darwin" ({pkgs, ...}:
          darwin.lib.darwinSystem {
            inherit pkgs;
            specialArgs = {inherit inputs;};
            modules = [./hosts/io];
          });

        # Not Tim Apple
        nixosConfigurations = let
          mkNixosHost = hostName: arch: (withSystem arch ({pkgs, ...}:
            nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs;
                inherit (pkgs) lib;
              };
              modules = [
                ./hosts/${hostName}
                ./modules/nixos
                {
                  node.hostName = hostName;
                  nixpkgs = {
                    hostPlatform = arch;
                    inherit (pkgs) overlays config;
                  };
                }
              ];
            }));
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
      };

      perSystem = {
        config,
        pkgs,
        self',
        system,
        ...
      }: {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            devshell.overlays.default
            (import ./pkgs/deploy.nix)
          ];
        };

        agenix-rekey.nodes = builtins.removeAttrs self.nixosConfigurations ["gonggong"];

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
        devshells.default = {
          packages = with pkgs; [
            age-plugin-yubikey
            nil
          ];

          devshell.startup.pre-commit.text = self'.checks.pre-commit-hooks.shellHook;

          commands = [
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
              inherit (config.agenix-rekey) package;
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
      };
    });
}
