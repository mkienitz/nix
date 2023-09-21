{...}: {
  imports = [
    ./hw-specific.nix

    ../../modules/nixos

    ../../modules/services/caddy.nix
  ];

  deployment.buildOnTarget = false;
}
