{
  config,
  inputs,
  lib,
  ...
}:
{
  options.flake.hosts = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          class = lib.mkOption {
            type = lib.types.enum [
              "nixos"
              "darwin"
            ];
          };
          system = lib.mkOption {
            type = lib.types.str;
          };
          age = lib.mkOption {
            type = lib.types.attrsOf lib.types.unspecified;
            default = { };
          };
        };
      }
    );
    default = { };
  };

  options.flake.factory = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.factory = {
    host =
      hostName:
      let
        host = config.flake.hosts.${hostName};
      in
      if host.class == "darwin" then
        inputs.self.lib.mkDarwinHost hostName host.system
      else
        inputs.self.lib.mkNixosHost hostName host.system;
    nginxProxy = inputs.self.lib.mkNginxProxy;
  };
}
