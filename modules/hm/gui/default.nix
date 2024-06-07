{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./kitty.nix
    ./fonts.nix
  ];

  config = lib.mkMerge [
    (lib.mkIf pkgs.stdenv.isLinux {
      home.packages = with pkgs; [
        discord
      ];
      programs.firefox.enable = true;
      stylix.targets.firefox.enable = true;
    })
  ];
}
