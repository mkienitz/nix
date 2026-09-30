{
  inputs,
  ...
}:
{
  flake.hosts.gonggong = {
    class = "nixos";
    system = "aarch64-linux";
    age = {
      rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAhraqL3Z1PN30SXavfCxmf8DIqWLuc1r0NOnksOzgea";
      identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
  };

  flake.nixosConfigurations = inputs.self.factory.host "gonggong";
}
