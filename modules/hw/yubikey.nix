_: {
  flake.modules.nixos.yubikey =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        yubikey-manager
        yubikey-personalization
        age-plugin-yubikey
      ];
      services.udev.packages = with pkgs; [
        yubikey-personalization
        libu2f-host
        libfido2
      ];
      services.pcscd.enable = true;
      users.groups.plugdev = { };
    };
}
