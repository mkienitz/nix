{ inputs, ... }:
{
  imports = [
    inputs.devshell.flakeModule
  ];

  perSystem =
    {
      config,
      pkgs,
      ...
    }:
    {
      devshells.default = {
        packages = with pkgs; [
          config.treefmt.build.wrapper
          nil
        ];
        # devshell.startup.pre-commit.text = lib.mkIf (
        #   config ? pre-commit
        # ) config.pre-commit.installationScript;
        commands = [
          {
            package = pkgs.deploy;
            help = "deploy config to host";
            category = "deployment";
          }
          {
            name = "drs";
            command = "sudo darwin-rebuild switch --flake . --show-trace";
            help = "rebuild darwin system";
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
          {
            package = pkgs.cleanup;
            help = "cleanup direnv mess";
            category = "other";
          }
        ];
      };
    };
}
