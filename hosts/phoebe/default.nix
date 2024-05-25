{inputs, ...}: {
  imports = [
    ./fs.nix
    ./hw-specific.nix

    ../../modules/nixos
    ../../modules/nixos/secrets
    ../../modules/nixos/impermanence.nix

    inputs.home-manager.nixosModules.default
    ../../users/max
    ../../modules/nixos/initrd-ssh.nix
  ];
  age.identityPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBivT5T9lDMrIL+hhRNEPr03lsBsgBV5jsELi61FGcIo";
}
