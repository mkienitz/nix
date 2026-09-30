{
  inputs,
  ...
}:
{
  flake.hosts.iapetus = {
    class = "nixos";
    system = "x86_64-linux";
    age = {
      rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG68RXutaqd1nUsLJU25GJo/GGWiikTiPd/asvSnQ2Gp";
      identityPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
    };
  };

  flake.nixosConfigurations = inputs.self.factory.host "iapetus";
}
