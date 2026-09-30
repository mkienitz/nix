{
  inputs,
  ...
}:
{
  flake.hosts.phoebe = {
    class = "nixos";
    system = "x86_64-linux";
    age = {
      rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBivT5T9lDMrIL+hhRNEPr03lsBsgBV5jsELi61FGcIo";
      identityPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
    };
  };

  flake.nixosConfigurations = inputs.self.factory.host "phoebe";
}
