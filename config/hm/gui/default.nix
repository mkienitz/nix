{ pkgs, ... }:
{
  imports = [
    ./kitty.nix
    ./fonts.nix
  ];
  home.packages = [
    pkgs.ghidra
  ];
}
