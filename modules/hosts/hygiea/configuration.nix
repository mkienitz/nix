{
  config,
  inputs,
  ...
}:
{
  flake.modules.nixos.hygiea = {
    imports = with inputs.self.modules.nixos; [
      # base
      system-base
      secrets
      # services
      nginx-base
      bql-print
      coffee-labeler
    ];
    age = config.flake.hosts.hygiea.age;
  };
}
