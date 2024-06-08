{
  imports = [
    # Machine & HW
    ./fs.nix
    ./hw-specific.nix
    ../../modules/nixos/hw/nvidia.nix
    ../../modules/nixos/hw/pipewire.nix
    # NixOS
    ../../modules/nixos
    ../../modules/nixos/secrets
    ../../modules/nixos/impermanence.nix
    ../../modules/nixos/yubikey.nix
    # GUI
    ../../modules/nixos/gui/stylix.nix
    ../../modules/nixos/gui/hyprland.nix
    # HM Nixos
    ../../modules/nixos/hm.nix
  ];

  # Home-Manager
  home-manager.users.max.imports = [
    ../../modules/hm/gui
    ../../modules/hm/gui/programs
    ../../modules/hm/gui/hyprland.nix
  ];

  # FIXME: why does this not work if put into modules/nixos/default.nix?
  nixpkgs.config.allowUnfree = true;

  nix.settings.extra-sandbox-paths = ["/tmp/agenix-rekey"];

  age.identityPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBivT5T9lDMrIL+hhRNEPr03lsBsgBV5jsELi61FGcIo";
}
