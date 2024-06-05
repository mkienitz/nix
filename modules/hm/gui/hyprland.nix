{pkgs, ...}: {
  home.packages = [(pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})];
  fonts.fontconfig.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod SHIFT, E, exit,"
        "$mod, Q, killactive,"
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, l"
      ];
    };
  };
}
