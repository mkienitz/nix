{
  programs.kitty = {
    enable = true;
    themeFile = "gruvbox-dark";
    settings = {
      # Font
      font_family = "JetBrainsMono Nerd Font Mono";
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
      window_padding_width = "10";
      disable_ligatures = "cursor";

      # Tab bar
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
  };
}
