{
  config,
  lib,
  ...
}: {
  boot = {
    extraModulePackages = [];
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod"];
      kernelModules = [];
    };
    kernelModules = ["kvm-intel"];
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
      options = ["zfsutil"]; # TODO: Needed?
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/09FD-4017";
      fsType = "vfat";
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableRedistributableFirmware = true;
  };

  networking = {
    hostId = "5ce254d7";
    hostName = "iapetus";
    useDHCP = lib.mkDefault true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  swapDevices = [];
}
