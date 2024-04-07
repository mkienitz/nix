{
  config,
  lib,
  pkgs,
  ...
}: {
  boot = {
    extraModulePackages = [];
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod"];
      kernelModules = [];
      systemd.enable = true;
      systemd.services.impermanence-root = {
        wantedBy = ["initrd.target"];
        after = ["zfs-import-rpool.service"];
        before = ["sysroot.mount"];
        unitConfig.DefaultDependencies = "no";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.zfs}/bin/zfs rollback -r rpool/local/root@blank";
        };
      };
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
