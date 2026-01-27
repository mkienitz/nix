{ lib, pkgs, ... }:
{
  xdg.configFile."karabiner/karabiner.json" = lib.mkIf pkgs.stdenv.isDarwin {
    source = ./karabiner.json;
  };
}
