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
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems."/" = {
    device = "rpool/root";
    fsType = "zfs";
    options = ["zfsutil"]; # TODO: Needed?
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/09FD-4017";
    fsType = "vfat";
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  networking = {
    useDHCP = lib.mkDefault true;
    hostId = "5ce254d7";
    hostName = "iapetus";
  };

  swapDevices = [];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
