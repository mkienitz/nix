{
  config,
  lib,
  ...
}: {
  imports = [
    ./hw-specific.nix
    ../../modules/nixos
    ./caddy.nix
  ];

  deployment.buildOnTarget = false;
}
