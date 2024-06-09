{config, ...}: {
  imports = [./fs.nix];
  boot = {
    initrd = {
      availableKernelModules = ["sdhci_pci" "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "r8169"];
    };
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    loader.efi.canTouchEfiVariables = true;
    binfmt.emulatedSystems = ["aarch64-linux"];
  };
  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };
  networking = {
    hostId = "de3825e6";
    useDHCP = true;
  };
}
