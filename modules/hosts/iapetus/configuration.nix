{
  config,
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
      nginx-base
      restic
      paperless
      coffee-vault
      home-assistant
      # searxng
    ];
    age = config.flake.hosts.iapetus.age;
  };
}
