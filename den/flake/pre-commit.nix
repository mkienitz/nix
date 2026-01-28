{ inputs, ... }:
{
  imports = [
    inputs.pre-commit-hooks.flakeModule
  ];

  perSystem =
    { config, ... }:
    {
      pre-commit.settings.hooks.treefmt.enable = config ? treefmt;
    };
}
