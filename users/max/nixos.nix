{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];
  users.users.max = {
    isNormalUser = true;
    shell = pkgs.zsh;
    inherit (config.users.users.root) hashedPassword;
  };
  security.doas.enable = true;
  security.doas.extraRules = [
    {
      users = ["max"];
      keepEnv = true;
    }
  ];
}
