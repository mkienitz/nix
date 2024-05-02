inputs: hostname: arch:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit inputs;
    inherit (inputs.self.pkgs.${arch}) lib;
  };
  modules = [
    ../hosts/${hostname}
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
      };
      options = {
        global.flakeRoot = lib.mkOption {
          type = lib.types.path;
          default = ../.;
        };
        node = {
          baseDir = lib.mkOption {
            type = lib.types.path;
            default = ../hosts + "/${config.node.hostname}";
          };
          secretsDir = lib.mkOption {
            type = lib.types.path;
            default = config.node.baseDir + "/secrets";
          };
          hostname = lib.mkOption {
            type = lib.types.str;
            default = hostname;
          };
        };
      };
    })
  ];
}
