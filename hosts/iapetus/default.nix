{ ... }:
{
  imports = [
    ../../config/nixos
    ../../config/nixos/secrets
    ../../config/nixos/impermanence.nix
    ./hw-specific.nix
    ./services
  ];
  age.identityPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG68RXutaqd1nUsLJU25GJo/GGWiikTiPd/asvSnQ2Gp";
}
