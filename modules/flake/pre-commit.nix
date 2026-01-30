{ inputs, ... }:
{
  imports = [
    inputs.git-hooks-nix.flakeModule
  ];

  perSystem =
    { config, ... }:
    {
      pre-commit.settings.hooks.treefmt.enable = config ? treefmt;
    };
}
