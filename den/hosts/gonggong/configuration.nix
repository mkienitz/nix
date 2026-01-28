{
  inputs,
  ...
}:
{
  flake.modules.nixos.gonggong = {
    imports = with inputs.self.modules.nixos; [
      # base
      system-base
      # services
      nginx-cloudflare
      bipper
      redirects
    ];
  };
}
