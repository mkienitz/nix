{
  config,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-persistenced"
      "nvidia-x11"
      "nvidia-settings"
    ];
  # TODO: needed?
  boot.blacklistedKernelModules = ["nouveau"];
  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      nvidiaPersistenced = true;
    };
  };
}
