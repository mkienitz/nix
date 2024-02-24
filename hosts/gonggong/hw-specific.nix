{
  config,
  modulesPath,
  lib,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot = {
    extraModulePackages = [];
    initrd = {
      availableKernelModules = ["xhci_pci" "usbhid" "sr_mod"];
      kernelModules = [];
    };
    kernelModules = [];
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "rpool/root";
      fsType = "zfs";
      options = ["zfsutil"];
    };

    "/home/max" = {
      device = "rpool/home";
      fsType = "zfs";
      options = ["zfsutil"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/4A0D-5796";
      fsType = "vfat";
    };
  };

  networking = {
    hostId = "600a1d45";
    hostName = "gonggong";
    useDHCP = lib.mkDefault true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  swapDevices = [];
}
