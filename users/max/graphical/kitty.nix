{
  programs.kitty = {
    enable = true;
    settings = {
      # Font
      font_family = "JetBrains Mono";
      font_size = "17.0";

      # Misc
      term = "xterm-256color";
      enable_audio_bell = "no";
      shell_integration = "no_cursor";
      cursor_blink_interval = "0";
      open_url_with = "default";
      url_style = "curly";
      detect_urls = "yes";
      confirm_os_window_close = "0";
      macos_titlebar_color = "background";
      # window_padding_width = "10";
      disable_ligatures = "cursor";

      # Colors based on https://github.com/morhetz/gruvbox by morhetz <morhetz@gmail.com>
      # Adapted to kitty by wdomitrz <witekdomitrz@gmail.com>
      cursor = "#928374";
      cursor_text_color = "background";
      url_color = "#83a598";
      visual_bell_color = "#8ec07c";
      bell_border_color = "#8ec07c";
      active_border_color = "#d3869b";
      inactive_border_color = "#665c54";
      background = "#282828";
      foreground = "#fbf1c7";
      selection_foreground = "#928374";
      selection_background = "#ebdbb2";
      active_tab_foreground = "#fbf1c7";
      active_tab_background = "#665c54";
      inactive_tab_foreground = "#a89984";
      inactive_tab_background = "#3c3836";
      color0 = "#665c54";
      color8 = "#7c6f64";
      color1 = "#cc241d";
      color9 = "#fb4934";
      color2 = "#98971a";
      color10 = "#b8bb26";
      color3 = "#d79921";
      color11 = "#fabd2f";
      color4 = "#458588";
      color12 = "#83a598";
      color5 = "#b16286";
      color13 = "#d3869b";
      color6 = "#689d6a";
      color14 = "#8ec07c";
      color7 = "#a89984";
      color15 = "#bdae93";
    };
  };
}
