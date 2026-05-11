_: {
  flake.modules.nixos.yubikey =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.yubikey-manager
        pkgs.yubikey-personalization
        pkgs.age-plugin-yubikey
      ];
      services.udev.packages = [
        pkgs.yubikey-personalization
        pkgs.libu2f-host
        pkgs.libfido2
      ];
      services.pcscd.enable = true;
      users.groups.plugdev = { };
    };
}
