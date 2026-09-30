{
  inputs,
  ...
}:
{
  flake.hosts.hygiea = {
    class = "nixos";
    system = "aarch64-linux";
    age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBERuCQLB+iYaaZ7IIXkV1m014orlGAWF+NJqLkteTc9";
  };

  flake.nixosConfigurations = inputs.self.factory.host "hygiea";
}
