inputs: hostName: arch:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit inputs;
    inherit (inputs.self.pkgs.${arch}) lib;
  };
  modules = [
    ../hosts/${hostName}
    ({
      lib,
      config,
      ...
    }: {
      config = {
        nixpkgs = {
          hostPlatform = arch;
          inherit (inputs.self.pkgs.${arch}) overlays config;
        };
        networking.hostName = config.node.hostName;
      };
      options = {
        global.flakeRoot = lib.mkOption {
          type = lib.types.path;
          default = ../.;
        };
        node = {
          baseDir = lib.mkOption {
            type = lib.types.path;
            default = ../hosts + "/${config.node.hostName}";
          };
          secretsDir = lib.mkOption {
            type = lib.types.path;
            default = config.node.baseDir + "/secrets";
          };
          hostName = lib.mkOption {
            type = lib.types.str;
            default = hostName;
          };
        };
      };
    })
  ];
}
