{...}: {
  imports = [
    ../../modules/nixos
    ../../modules/common/secrets
    ./hw-specific.nix
    ./services
  ];
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ1cev+rDMmSuIyaANj8x71jO5j7b2SEa/VhAXEOE7Ym";
}
