{pkgs, ...}: {
  home.packages = with pkgs; [
    discord
  ];
  programs.firefox.enable = true;
  stylix.targets.firefox.enable = true;
}
