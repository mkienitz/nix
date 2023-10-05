{...}: {
  imports = [
    ./hw-specific.nix

    ../../modules/nixos

    ./services
  ];
}
