{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.default
    ../common/hm.nix
  ];
  users.users.max = {
    isNormalUser = true;
    shell = pkgs.zsh;
    inherit (config.users.users.root) hashedPassword;
  };
  security.doas = {
    enable = true;
    extraRules = [
      {
        users = [ "max" ];
        keepEnv = true;
      }
    ];
  };
}
