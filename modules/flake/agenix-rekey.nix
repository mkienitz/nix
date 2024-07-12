{
  inputs,
  self,
  ...
}: {
  imports = [
    inputs.agenix-rekey.flakeModule
  ];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    agenix-rekey.nodes = builtins.removeAttrs self.nixosConfigurations ["gonggong"];

    devshells.default = {
      packages = with pkgs; [
        age-plugin-yubikey
      ];
      commands = [
        {
          inherit (config.agenix-rekey) package;
          help = "create and edit secrets";
          category = "other";
        }
      ];
    };
  };
}
