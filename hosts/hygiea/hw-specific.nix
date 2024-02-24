{
  pkgs,
  lib,
  ...
}: {
  boot = {
    initrd.availableKernelModules = ["xhci_pci" "usbhid" "usb_storage"];
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    loader = {
      generic-extlinux-compatible.enable = true;
      grub.enable = false;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = ["noatime"];
    };
  };

  hardware.enableRedistributableFirmware = true;

  networking = {
    hostId = "15e1ade1";
    hostName = "hygiea";
    useDHCP = lib.mkDefault true;
  };
}
