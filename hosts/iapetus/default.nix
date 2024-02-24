{...}: {
  imports = [
    ../../modules/nixos
    ./hw-specific.nix
    ./services
  ];
}
