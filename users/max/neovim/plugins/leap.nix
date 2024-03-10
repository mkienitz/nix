_: {
  programs.nixvim = {
    plugins = {
      leap = {
        enable = true;
      };
    };
    keymaps = [
      {
        key = "s";
        mode = "n";
        action = "<Plug>(leap-forward-to)";
        options = {
          desc = "Leap forward";
        };
      }
      {
        key = "S";
        mode = "n";
        action = "<Plug>(leap-backward-to)";
        options = {
          desc = "Leap backward";
        };
      }
      {
        key = "gs";
        mode = "n";
        action = "<Plug>(leap-cross-windows)";
        options = {
          desc = "Cross-dimensional leap";
        };
      }
    ];
  };
}
