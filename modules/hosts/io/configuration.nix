{
  config,
  inputs,
  ...
}:
{
  flake.modules.darwin.io = {
    imports = with inputs.self.modules.darwin; [
      system-base
      secrets
      # user
      max
    ];

    age = config.flake.hosts.io.age;
  };
}
