{ config, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        output = [
          "DP-1"
          "DP-2"
        ];
        modules-left = [
          "hyprland/workspaces"
          "wlr/taskbar"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "temperature"
          "cpu"
          "memory"
          "pulseaudio"
          "tray"
          "clock"
        ];
        cpu = {
          interval = 5;
          format = "CPU: {usage}%";
        };
        memory = {
          interval = 5;
          format = "RAM: {used:0.1f}G/{total:0.1f}G";
        };
        pulseaudio = {
          format = "Vol: {volume}%";
          scroll-step = 4;
        };
        clock = {
          format = "{:%d.%m.%Y %H:%M}";
        };
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
      };
    };
    style =
      # css
      ''
        * {
          font-family: JetBrainsMono Nerd Font;
        }
        window#waybar {
          background: #${config.lib.stylix.colors.base00-hex};
        }
        #pulseaudio, #cpu, #memory, #clock {
          padding: 0 20px;
        }
      '';
  };
}
