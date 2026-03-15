{
  inputs,
  ...
}:
{
  flake.modules.nixos.gonggong = {
    imports = with inputs.self.modules.nixos; [
      # base
      system-base
      secrets
      # services
      nginx-cloudflare
      bipper
      redirects
      portfolio
    ];

    age = {
      # TODO maybe pass to secret factory instead?
      rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAhraqL3Z1PN30SXavfCxmf8DIqWLuc1r0NOnksOzgea";
      identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
  };
}
