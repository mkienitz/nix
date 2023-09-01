{
  config,
  pkgs,
  ...
}: {
  home.packages = [];
  home.stateVersion = "23.11";

  programs.git = {
    enable = true;
    userName = "Maximilian Kienitz";
    userEmail = "max@kienitz.dev";
  };

  programs.zsh = {
    enable = true;
    history.size = 100000;
    history.save = 100000;
  };

  home.shellAliases = {
    ll = "ls -l";
    la = "ls -la";
    lg = "lazygit";
    update = "sudo nixos-rebuild --flake ~/nix-config switch";
  };

  programs.lazygit = {
    enable = true;
    settings = {
      disableStartupPopups = true;
      gui = {
        showCommandLog = true;
        showFileTree = true;
        showIcons = true;
        showListFooter = false;
        showRandomTip = false;
        theme = {
          activeBorderColor = ["blue" "bold"];
          cherryPickedCommitBgColor = ["cyan"];
          cherryPickedCommitFgColor = ["blue"];
          inactiveBorderColor = ["white"];
          optionsTextColor = ["blue"];
          selectedLineBgColor = ["default"];
          selectedRangeBgColor = ["default"];
          unstagedChangesColor = ["red"];
        };
      };
      notARepository = "skip";
      os = {editPreset = "nvim";};
    };
  };
  
  services.ssh-agent.enable = true;
}
