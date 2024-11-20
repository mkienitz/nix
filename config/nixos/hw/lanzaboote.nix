{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];
  boot = {
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };
  environment = lib.mkIf (config.environment ? persistence) {
    persistence."/state".directories = [ "/etc/secureboot" ];
  };
}
