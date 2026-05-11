{
  flake.modules.homeManager.ghostty =
    { pkgs, ... }:
    {
      programs.ghostty = {
        enable = true;
        package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
        settings = {
          font-family = "JetBrains Mono";
          font-size = 16;
          theme = "Gruvbox Dark";
          keybind = "global:cmd+backquote=toggle_quick_terminal";
          quick-terminal-position = "center";
          quick-terminal-size = "50%,50%";
          quick-terminal-animation-duration = 0;
          bell-features = "system";
          macos-titlebar-style = "tabs";
          macos-titlebar-proxy-icon = "hidden";
          macos-option-as-alt = true;
          clipboard-paste-protection = false;
          clipboard-read = "allow";
          clipboard-write = "allow";
          shell-integration-features = "ssh-env";
        };
      };
    };
}
