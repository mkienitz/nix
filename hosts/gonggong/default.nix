{...}: {
  imports = [
    ./hw-specific.nix

    ../../modules/nixos

    ./services/nginx.nix
  ];

  deployment.buildOnTarget = false;
}
