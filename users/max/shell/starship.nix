{
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = let
      flavour = "mocha";
    in
      {
        "$schema" = "https://starship.rs/config-schema.json";
        c = {
          format = "[[ $symbol( $version) ](fg:surface0 bg:teal)]($style)";
          style = "bg:teal";
          symbol = " ";
        };
        character = {
          disabled = false;
          error_symbol = "[❯](bold fg:red)";
          success_symbol = "[❯](bold fg:green)";
        };
        directory = {
          format = "[ $path ]($style)";
          style = "fg:surface0 bg:yellow";
          truncation_length = 3;
          truncation_symbol = "…/";
        };
        docker_context = {
          format = "[[ $symbol( $context) ](fg:surface0 bg:blue)]($style)";
          style = "bg:blue";
          symbol = "";
        };
        format = lib.concatStrings [
          "[](peach)$os$username[](fg:peach bg:yellow)"
          "$directory[](fg:yellow bg:green)"
          "$git_branch$git_status[](fg:green bg:teal)"
          "$c$rust$golang$nodejs$php$java$kotlin$haskell$python[](fg:teal bg:blue)"
          "$nix_shell$docker_context[](fg:blue bg:maroon)"
          "$time[ ](fg:maroon)"
          "$line_break$character"
        ];
        git_branch = {
          format = "[[ $symbol $branch ](fg:surface0 bg:green)]($style)";
          style = "bg:green";
          symbol = "";
        };
        git_status = {
          format = "[[($all_status$ahead_behind )](fg:surface0 bg:green)]($style)";
          style = "bg:green";
        };
        golang = {
          format = "[[ $symbol( $version) ](fg:surface0 bg:teal)]($style)";
          style = "bg:teal";
          symbol = "";
        };
        haskell = {
          format = "[[ $symbol( $version) ](fg:surface0 bg:teal)]($style)";
          style = "bg:teal";
          symbol = "";
        };
        java = {
          format = "[[ $symbol( $version) ](fg:surface0 bg:teal)]($style)";
          style = "bg:teal";
          symbol = " ";
        };
        kotlin = {
          format = "[[ $symbol( $version) ](fg:surface0 bg:teal)]($style)";
          style = "bg:teal";
          symbol = "";
        };
        line_break = {disabled = false;};
        nix_shell = {
          format = "[ $symbol( \\($name\\)) ](fg:surface0 bg:blue)($style)";
          style = "bg:blue";
          symbol = "";
        };
        nodejs = {
          format = "[[ $symbol( $version) ](fg:surface0 bg:teal)]($style)";
          style = "bg:teal";
          symbol = "";
        };
        os = {
          disabled = false;
          style = "bg:peach fg:surface0";
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
        python = {
          format = "[[ $symbol( $version) ](fg:surface0 bg:teal)]($style)";
          style = "bg:teal";
          symbol = "";
        };
        rust = {
          format = "[[ $symbol( $version) ](fg:surface0 bg:teal)]($style)";
          style = "bg:teal";
          symbol = "";
        };
        time = {
          disabled = false;
          format = "[[  $time ](fg:surface0 bg:maroon)]($style)";
          style = "bg:maroon";
          time_format = "%R";
        };
        username = {
          format = "[ $user ]($style)";
          show_always = true;
          style_root = "bg:peach fg:surface0";
          style_user = "bg:peach fg:surface0";
        };
        palette = "catppuccin_${flavour}";
      }
      // builtins.fromTOML (builtins.readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f"; # Replace with the latest commit hash
            hash = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
          }
          + /palettes/${flavour}.toml));
    # Catppuccin palette reference
    # rosewater = "#f5e0dc"
    # flamingo = "#f2cdcd"
    # pink = "#f5c2e7"
    # mauve = "#cba6f7"
    # red = "#f38ba8"
    # maroon = "#eba0ac"
    # peach = "#fab387"
    # yellow = "#f9e2af"
    # green = "#a6e3a1"
    # teal = "#94e2d5"
    # sky = "#89dceb"
    # sapphire = "#74c7ec"
    # blue = "#89b4fa"
    # lavender = "#b4befe"
    # text     = "#cdd6f4"
    # subtext1 = "#bac2de"
    # subtext0 = "#a6adc8"
    # overlay2 = "#9399b2"
    # overlay1 = "#7f849c"
    # overlay0 = "#6c7086"
    # surface2 = "#585b70"
    # surface1 = "#45475a"
    # surface0 = "#313244"
    # base = "#1e1e2e"
    # mantle = "#181825"
    # crust = "#11111b"
  };
}
