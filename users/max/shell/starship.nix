{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      c = {
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        style = "bg:color_blue";
        symbol = " ";
      };
      character = {
        disabled = false;
        error_symbol = "[❯](bold fg:color_red)";
        success_symbol = "[❯](bold fg:color_green)";
      };
      directory = {
        format = "[ $path ]($style)";
        style = "fg:color_fg0 bg:color_yellow";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      docker_context = {
        format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
        style = "bg:color_bg3";
        symbol = "";
      };
      format = "[](color_orange)$os$username[](fg:color_orange bg:color_yellow)$directory[](fg:color_yellow bg:color_aqua)$git_branch$git_status[](fg:color_aqua bg:color_blue)$c$rust$golang$nodejs$php$java$kotlin$haskell$python[](fg:color_blue bg:color_bg3)$nix_shell$docker_context[](fg:color_bg3 bg:color_bg1)$time[ ](fg:color_bg1)$line_break$character";
      git_branch = {
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
        style = "bg:color_aqua";
        symbol = "";
      };
      git_status = {
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
        style = "bg:color_aqua";
      };
      golang = {
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        style = "bg:color_blue";
        symbol = "";
      };
      haskell = {
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        style = "bg:color_blue";
        symbol = "";
      };
      java = {
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        style = "bg:color_blue";
        symbol = " ";
      };
      kotlin = {
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        style = "bg:color_blue";
        symbol = "";
      };
      line_break = {disabled = false;};
      nix_shell = {
        format = "[$symbol( \\($name\\))]($style)";
        style = "bg:color_bg3";
        symbol = "";
      };
      nodejs = {
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        style = "bg:color_blue";
        symbol = "";
      };
      os = {
        disabled = false;
        style = "bg:color_orange fg:color_fg0";
        symbols = {
          Arch = "󰣇";
          Debian = "󰣚";
          Fedora = "󰣛";
          Linux = "󰌽";
          Macos = "󰀵";
          NixOS = "";
          Raspbian = "󰐿";
          Ubuntu = "󰕈";
          Windows = "󰍲";
        };
      };
      palette = "gruvbox_dark";
      palettes = {
        gruvbox_dark = {
          color_aqua = "#689d6a";
          color_bg1 = "#3c3836";
          color_bg3 = "#665c54";
          color_blue = "#458588";
          color_fg0 = "#fbf1c7";
          color_green = "#98971a";
          color_orange = "#d65d0e";
          color_purple = "#b16286";
          color_red = "#cc241d";
          color_yellow = "#d79921";
        };
      };
      php = {
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        style = "bg:color_blue";
        symbol = "";
      };
      python = {
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        style = "bg:color_blue";
        symbol = "";
      };
      rust = {
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
        style = "bg:color_blue";
        symbol = "";
      };
      time = {
        disabled = false;
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
        style = "bg:color_bg1";
        time_format = "%R";
      };
      username = {
        format = "[ $user ]($style)";
        show_always = true;
        style_root = "bg:color_orange fg:color_fg0";
        style_user = "bg:color_orange fg:color_fg0";
      };
    };
  };
}
