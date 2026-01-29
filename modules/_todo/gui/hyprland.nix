{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.greetd}/bin/agreety --cmd ${pkgs.hyprland}/bin/Hyprland";
    };
  };
}
