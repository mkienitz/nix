{
  config,
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

    age = config.flake.hosts.gonggong.age;
  };
}
