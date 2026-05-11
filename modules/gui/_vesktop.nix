{ pkgs, ... }:
{
  home.packages = [ pkgs.vesktop ];
  home.persistence."/state".directories = [
    ".config/vesktop"
  ];
  stylix.targets.vesktop.enable = true;
}
