{ pkgs, ... }:
{
  home.packages = [ pkgs.pavucontrol ];
  home.persistence."/state".directories = [
    ".local/state/wireplumber"
  ];
}
