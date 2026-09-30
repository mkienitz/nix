{
  config,
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
    age = config.flake.hosts.phoebe.age;
  };
}
