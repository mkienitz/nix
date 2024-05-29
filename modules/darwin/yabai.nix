{
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = {
      # Monterey - start scripting addition automatically
      debug_output = "on";
      window_border = "on";
      window_border_width = 2;
      window_gap = 10;
      normal_window_border_colors = "0xff45475a";
      active_window_border_color = "0xffb4befe";
      layout = "bsp";
      window_shadow = "float";
    };
  };
  services.skhd = {
    enable = true;
    skhdConfig = ''
      # Window focus
      hyper - h : yabai -m window --focus west
      hyper - j : yabai -m window --focus south
      hyper - k : yabai -m window --focus north
      hyper - l : yabai -m window --focus east

      # Window movement
      hyper - u : yabai -m window --warp west
      hyper - i : yabai -m window --warp south
      hyper - o : yabai -m window --warp north
      hyper - p : yabai -m window --warp east

      # Window size adjustment
      hyper - a : yabai -m window --resize left:-50:0; yabai -m window --resize right:-50:0
      hyper - s : yabai -m window --resize bottom:0:50; yabai -m window --resize top:0:50
      hyper - d : yabai -m window --resize top:0:-50; yabai -m window --resize bottom:0:-50
      hyper - f : yabai -m window --resize right:50:0; yabai -m window --resize left:50:0
      hyper - return : yabai -m window --toggle zoom-fullscreen

      # Applications
      hyper - 0x32 : open -na /Applications/kitty.app/Contents/MacOS/kitty

      # Rotation and balance
      hyper - t : yabai -m space --mirror y-axis
      hyper - y : yabai -m space --rotate 90
      hyper - g : yabai -m space --balance

      # Float and unfloat
      hyper - space : yabai -m window --toggle float; yabai -m window --toggle border

      # Space focus
      hyper - 1 : yabai -m space --focus 1
      hyper - 2 : yabai -m space --focus 2
      hyper - 3 : yabai -m space --focus 3
      hyper - 4 : yabai -m space --focus 4
      hyper - 0x21 : yabai -m space --focus prev
      hyper - 0x1E : yabai -m space --focus next

      # Space window movement
      hyper - q : yabai -m window --space 1; yabai -m space --focus 1
      hyper - w : yabai -m window --space 2; yabai -m space --focus 2
      hyper - e : yabai -m window --space 3; yabai -m space --focus 3
      hyper - r : yabai -m window --space 4; yabai -m space --focus 4
    '';
  };
}
