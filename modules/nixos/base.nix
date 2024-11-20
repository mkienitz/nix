{
  config,
  lib,
  ...
}:
{
  options = {
    global.flakeRoot = lib.mkOption {
      type = lib.types.path;
      default = ../..;
    };
    node = {
      baseDir = lib.mkOption {
        type = lib.types.path;
        default = ../../hosts + "/${config.node.hostName}";
      };
      secretsDir = lib.mkOption {
        type = lib.types.path;
        default = config.node.baseDir + "/secrets";
      };
      hostName = lib.mkOption {
        type = lib.types.str;
      };
    };
  };
  config = {
    networking.hostName = config.node.hostName;
  };
}
