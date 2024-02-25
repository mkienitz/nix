{...}: {
  imports = [
    ../../modules/nixos
    ../../modules/common/secrets
    ./hw-specific.nix
    ./services
  ];

  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBERuCQLB+iYaaZ7IIXkV1m014orlGAWF+NJqLkteTc9";
}
