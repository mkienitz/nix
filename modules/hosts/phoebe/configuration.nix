{
  inputs,
  ...
}:
{
  flake.modules.nixos.phoebe = {
    imports = with inputs.self.modules.nixos; [
      # base
      system-base
      secrets
      impermanence

      # boot
      lanzaboote
      initrd-ssh

      # extra
      yubikey
      nvidia

      # user
      max
    ];
    age.identityPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
    age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBivT5T9lDMrIL+hhRNEPr03lsBsgBV5jsELi61FGcIo";
  };
}
