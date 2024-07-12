{inputs, ...}: {
  imports = [
    inputs.devshell.flakeModule
    inputs.pre-commit-hooks.flakeModule
  ];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    formatter = pkgs.alejandra;

    pre-commit.settings.hooks = {
      alejandra.enable = true;
      deadnix.enable = true;
      statix.enable = true;
    };

    devshells.default = {
      packages = with pkgs; [
        nil
      ];
      devshell.startup.pre-commit.text = config.pre-commit.installationScript;
      commands = [
        {
          package = pkgs.callPackage (pkgs.fetchFromGitHub
            {
              owner = "oddlama";
              repo = "nix-config";
              rev = "93061af475f718bdf3c34e69e419e3db92efabd7";
              hash = "sha256-ogTW26huURJqfFmniN512ygsTcLlh3IuY2+IOhykKjI=";
            }
            + "/pkgs/deploy.nix") {};
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
          package = pkgs.nix-tree;
          help = "browse dependency graph of derivations";
          category = "other";
        }
      ];
    };
  };
}
