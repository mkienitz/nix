{pkgs, ...}: {
  home.packages = with pkgs; [vesktop];
  home.persistence."/state".directories = [
    ".config/vesktop"
  ];
  stylix.targets.vesktop.enable = true;
}
