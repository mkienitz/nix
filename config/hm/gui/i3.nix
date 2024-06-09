{
  config,
  lib,
  ...
}: {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      focus.followMouse = false;
      focus.mouseWarping = false;
    };
  };
  home.file.".xinitrc".text = ''
    if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
      eval $(dbus-launch --exit-with-session --sh-syntax)
    fi

    export DESKTOP_SESSION=i3
    systemctl --user import-environment PATH DISPLAY XAUTHORITY DESKTOP_SESSION XDG_CONFIG_DIRS XDG_DATA_DIRS XDG_RUNTIME_DIR XDG_SESSION_ID DBUS_SESSION_BUS_ADDRESS
    if command -v dbus-update-activation-environment >/dev/null 2>&1; then
      dbus-update-activation-environment --systemd --all
    fi

    autorandr -c
    xset mouse 1 0
    xset r rate 235 60

    [[ -f "$HOME"/${lib.escapeShellArg config.xsession.scriptPath} ]] \
      && source "$HOME"/${lib.escapeShellArg config.xsession.scriptPath}

    exec i3
  '';
}
