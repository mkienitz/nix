{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./kitty.nix
  ];

  config = lib.mkMerge [
    (lib.mkIf pkgs.stdenv.isLinux {
      fonts.fontconfig.enable = true;
      home.packages = with pkgs; [
        (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})
        discord
      ];
      programs.firefox.enable = true;
      stylix.targets.firefox.enable = true;
    })
  ];
}
