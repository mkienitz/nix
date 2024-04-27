{inputs, ...}: {
  imports = [
    ../../modules/nixos
    ../../modules/nixos/secrets
    ./hw-specific.nix
    ./services
    inputs.impermanence.nixosModules.impermanence
  ];
  environment.persistence = {
    "/state" = {
      hideMounts = true;
      directories = [
        "/var/lib/systemd"
        "/var/log"
        "/var/spool"
      ];
    };
    "/persist" = {
      hideMounts = true;
      files = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/machine-id"
      ];
    };
  };
  age.identityPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG68RXutaqd1nUsLJU25GJo/GGWiikTiPd/asvSnQ2Gp";
}
