{lib, ...}: {
  programs.tofi.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      general = {
        gaps_in = 5;
        gaps_out = 5;
      };
      monitor = [
        "DP-1, 3840x1600@119.98, 0x0, 1, bitdepth, 10"
        "DP-2, 2560x1440@120.00, -1440x-370, 1, transform, 1"
        # Begone
        "Unknown-1, disable"
      ];
      workspace = [
        "1, monitor:DP-1, default: true"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:DP-2, default: true"
        "7, monitor:DP-2"
        "8, monitor:DP-2"
        "9, monitor:DP-2"
      ];
      # Longer shared edges have priority
      binds.focus_preferred_method = 1;
      bind =
        [
          # General
          "SUPER SHIFT, E, exit,"
          # Windows
          "SUPER, Q, killactive,"
          "SUPER, H, movefocus, l"
          "SUPER, J, movefocus, d"
          "SUPER, K, movefocus, u"
          "SUPER, L, movefocus, r"
          "SUPER SHIFT, H, movewindow, l"
          "SUPER SHIFT, J, movewindow, d"
          "SUPER SHIFT, K, movewindow, u"
          "SUPER SHIFT, L, movewindow, r"
          "SUPER, TAB, cyclenext,"
          "SUPER SHIFT, TAB, cyclenext, prev"
          "SUPER, F, fullscreen, 1"
          # Programs
          "SUPER, RETURN, exec, kitty"
          "SUPER, B, exec, firefox"
          "SUPER, D, exec, tofi-drun | xargs hyprctl dispatch exec --"
        ]
        ++ (builtins.concatMap (n: [
          "SUPER, ${n}, workspace, ${n}"
          "SUPER SHIFT, ${n}, movetoworkspacesilent, ${n}"
        ]) (map builtins.toString (lib.range 1 9)));
      bindm = [
        # left click
        "SUPER, mouse:272, movewindow"
        # right click
        "SUPER, mouse:273, resizewindow"
      ];
      input = {
        # Keyboard
        kb_layout = "us";
        kb_variant = "altgr-intl";
        kb_options = "nodeadkeys";
        repeat_rate = 50;
        repeat_delay = 250;
        # Mouse
        follow_mouse = 2;
        sensitivity = 0.5;
        accel_profile = "flat";
      };
      misc = {
        disable_hyprland_logo = true;
      };
    };
  };
}
