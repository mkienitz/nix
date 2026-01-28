{
  inputs,
  ...
}:
{
  flake.modules.nixos.iapetus = {
    imports = with inputs.self.modules.nixos; [
      # Basic
      system-base
      secrets
      impermanence
      # Services
      restic
      paperless
      coffee-vault
    ];
    age = {
      # TODO maybe pass to secret factory instead?
      rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG68RXutaqd1nUsLJU25GJo/GGWiikTiPd/asvSnQ2Gp";
      identityPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
    };
  };
}
