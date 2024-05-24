{config, ...}: {
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod"];
      systemd.enable = true;
    };
    kernelModules = ["kvm-intel"];
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/896B-8534";
      fsType = "vfat";
    };
    "/" = {
      device = "rpool/local/root";
      fsType = "zfs";
      options = ["zfsutil"];
    };
    "/nix" = {
      device = "rpool/local/nix";
      fsType = "zfs";
      options = ["zfsutil"];
      neededForBoot = true;
    };
    "/state" = {
      device = "rpool/local/state";
      fsType = "zfs";
      options = ["zfsutil"];
      neededForBoot = true;
    };
    "/persist" = {
      device = "rpool/safe/persist";
      fsType = "zfs";
      options = ["zfsutil"];
      neededForBoot = true;
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  networking = {
    hostId = "5ce254d7";
    hostName = config.node.hostname;
    useDHCP = true;
  };
}
