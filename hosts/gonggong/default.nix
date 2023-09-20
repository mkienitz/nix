{
  config,
  modulesPath,
  lib,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../../modules/nixos
    ../../users/max
    ./caddy.nix
  ];

  deployment.buildOnTarget = false;

  # Hardware specific
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "usbhid" "sr_mod"];
      kernelModules = [];
    };
    kernelModules = [];
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    extraModulePackages = [];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems."/" = {
    device = "rpool/root";
    fsType = "zfs";
    options = ["zfsutil"];
  };

  fileSystems."/home/max" = {
    device = "rpool/home";
    fsType = "zfs";
    options = ["zfsutil"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4A0D-5796";
    fsType = "vfat";
  };

  swapDevices = [];

  networking = {
    useDHCP = lib.mkDefault true;
    hostId = "600a1d45";
    hostName = "gonggong";
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
