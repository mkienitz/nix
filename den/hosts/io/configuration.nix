{
  inputs,
  ...
}:
{
  flake.modules.darwin.io = {
    imports = with inputs.self.modules.darwin; [
      system-base
      # user
      max
    ];
  };
}
