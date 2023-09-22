{...}: {
  imports = [
    ./hw-specific.nix

    ../../modules/nixos

    ./services
  ];

  deployment.buildOnTarget = false;
}
